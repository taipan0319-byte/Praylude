import 'package:flutter/foundation.dart';

import '../models/content.dart';
import '../services/content_service.dart';
import '../services/storage_service.dart';

/// Single source of truth, same pattern as Grove.
///
/// Progress model ("faithfulness, not calendar"): a track or novena is a
/// SEQUENCE — you are always on the next incomplete day. Missing real-world
/// days stretches the duration; nothing ever resets.
class AppState extends ChangeNotifier {
  final StorageService _storage;
  final ContentService _content;

  Map<String, Track> tracks = {};
  List<Novena> novenas = [];
  bool loaded = false;

  AppState(this._storage, this._content);

  Future<void> load() async {
    tracks = await _content.loadTracks();
    novenas = await _content.loadNovenas();
    loaded = true;
    notifyListeners();
  }

  // --- Onboarding / preferences -------------------------------------------

  bool get onboarded => _storage.onboarded;
  String get trackPreference => _storage.trackPreference;

  Future<void> completeOnboarding(String trackPref) async {
    await _storage.setTrackPreference(trackPref);
    await _storage.setOnboarded();
    notifyListeners();
  }

  Future<void> setTrackPreference(String pref) async {
    await _storage.setTrackPreference(pref);
    notifyListeners();
  }

  // --- Daily track progress -----------------------------------------------

  /// Tracks shown on Today, per preference ('both' shows both).
  List<Track> get activeTracks {
    final pref = trackPreference;
    if (pref == 'both') return tracks.values.toList();
    final t = tracks[pref];
    return t == null ? tracks.values.toList() : [t];
  }

  int completedDays(String trackId) => _storage.trackProgress[trackId] ?? 0;

  /// The entry the user is currently on: next incomplete day, capped at the
  /// last available entry once content runs out.
  DailyEntry currentEntry(Track track) {
    final idx = completedDays(track.id).clamp(0, track.days.length - 1);
    return track.days[idx];
  }

  bool trackFinished(Track track) => completedDays(track.id) >= track.days.length;

  Future<void> completeCurrentEntry(Track track) async {
    if (trackFinished(track)) return;
    final progress = Map<String, int>.from(_storage.trackProgress);
    progress[track.id] = (progress[track.id] ?? 0) + 1;
    await _storage.setTrackProgress(progress);
    await _recordPrayedToday();
    notifyListeners();
  }

  // --- Novenas ------------------------------------------------------------

  int novenaCompletedDays(String novenaId) =>
      _storage.novenaProgress[novenaId] ?? 0;

  bool novenaStarted(String novenaId) =>
      _storage.novenaProgress.containsKey(novenaId);

  bool novenaFinished(Novena n) => novenaCompletedDays(n.id) >= n.days.length;

  /// Current day (1-based) within a started novena.
  int novenaCurrentDay(Novena n) =>
      (novenaCompletedDays(n.id) + 1).clamp(1, n.days.length);

  Future<void> startNovena(Novena n) async {
    if (novenaStarted(n.id)) return;
    final progress = Map<String, int>.from(_storage.novenaProgress);
    progress[n.id] = 0;
    await _storage.setNovenaProgress(progress);
    notifyListeners();
  }

  Future<void> completeNovenaDay(Novena n) async {
    if (novenaFinished(n)) return;
    final progress = Map<String, int>.from(_storage.novenaProgress);
    progress[n.id] = (progress[n.id] ?? 0) + 1;
    await _storage.setNovenaProgress(progress);
    await _recordPrayedToday();
    notifyListeners();
  }

  // --- Faithfulness record ------------------------------------------------

  static String _dateKey(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<void> _recordPrayedToday() async {
    final dates = List<String>.from(_storage.prayedDates);
    final today = _dateKey(DateTime.now());
    if (!dates.contains(today)) {
      dates.add(today);
      await _storage.setPrayedDates(dates);
    }
  }

  int get totalDaysPrayed => _storage.prayedDates.length;

  bool get prayedToday =>
      _storage.prayedDates.contains(_dateKey(DateTime.now()));

  /// Consecutive calendar days ending today (or yesterday, so an unfinished
  /// today never shows as a break). Never displayed as "lost" — the record
  /// screen leads with totalDaysPrayed.
  int get currentStreak {
    final dates = _storage.prayedDates.toSet();
    if (dates.isEmpty) return 0;
    var day = DateTime.now();
    if (!dates.contains(_dateKey(day))) {
      day = day.subtract(const Duration(days: 1));
      if (!dates.contains(_dateKey(day))) return 0;
    }
    var streak = 0;
    while (dates.contains(_dateKey(day))) {
      streak++;
      day = day.subtract(const Duration(days: 1));
    }
    return streak;
  }

  // --- Dev ----------------------------------------------------------------

  Future<void> resetAll() async {
    await _storage.resetAll();
    notifyListeners();
  }
}
