import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/content.dart';

/// Loads the bundled content JSON. All prayer content ships inside the app —
/// no backend, nothing leaves the device.
class ContentService {
  static const trackAssets = {
    'prepare': 'assets/content/daily_prepare.json',
    'seek': 'assets/content/daily_seek.json',
  };
  static const novenaAssets = ['assets/content/novena_raphael.json'];

  Future<Map<String, Track>> loadTracks() async {
    final tracks = <String, Track>{};
    for (final entry in trackAssets.entries) {
      final raw = await rootBundle.loadString(entry.value);
      tracks[entry.key] =
          Track.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    }
    return tracks;
  }

  Future<List<Novena>> loadNovenas() async {
    final novenas = <Novena>[];
    for (final asset in novenaAssets) {
      final raw = await rootBundle.loadString(asset);
      novenas.add(Novena.fromJson(jsonDecode(raw) as Map<String, dynamic>));
    }
    return novenas;
  }
}
