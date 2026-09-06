import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Thin persistence layer. Milestone 1 backs this with shared_preferences;
/// the letters-journal milestone replaces the backing store with a real
/// database (Drift/SQLite) behind this same interface.
class StorageService {
  static const _kTrackPref = 'track_preference'; // 'prepare' | 'seek' | 'both'
  static const _kOnboarded = 'onboarded';
  static const _kTrackProgress = 'track_progress'; // {trackId: completedDays}
  static const _kPrayedDates = 'prayed_dates'; // ["2026-09-06", ...]
  static const _kNovenaProgress = 'novena_progress'; // {novenaId: completedDays}

  final SharedPreferences _prefs;
  StorageService(this._prefs);

  static Future<StorageService> create() async =>
      StorageService(await SharedPreferences.getInstance());

  bool get onboarded => _prefs.getBool(_kOnboarded) ?? false;
  Future<void> setOnboarded() => _prefs.setBool(_kOnboarded, true);

  String get trackPreference => _prefs.getString(_kTrackPref) ?? 'both';
  Future<void> setTrackPreference(String v) => _prefs.setString(_kTrackPref, v);

  Map<String, int> _intMap(String key) {
    final raw = _prefs.getString(key);
    if (raw == null) return {};
    return (jsonDecode(raw) as Map<String, dynamic>)
        .map((k, v) => MapEntry(k, v as int));
  }

  Future<void> _setIntMap(String key, Map<String, int> m) =>
      _prefs.setString(key, jsonEncode(m));

  Map<String, int> get trackProgress => _intMap(_kTrackProgress);
  Future<void> setTrackProgress(Map<String, int> m) =>
      _setIntMap(_kTrackProgress, m);

  Map<String, int> get novenaProgress => _intMap(_kNovenaProgress);
  Future<void> setNovenaProgress(Map<String, int> m) =>
      _setIntMap(_kNovenaProgress, m);

  List<String> get prayedDates => _prefs.getStringList(_kPrayedDates) ?? [];
  Future<void> setPrayedDates(List<String> dates) =>
      _prefs.setStringList(_kPrayedDates, dates);

  Future<void> resetAll() => _prefs.clear();
}
