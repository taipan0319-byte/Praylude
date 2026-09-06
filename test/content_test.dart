import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:praylude/models/content.dart';

/// Content validation — malformed content fails the build, not the user's
/// morning prayer. Reads the JSON straight from disk so these run without
/// a device.
void main() {
  Map<String, dynamic> readJson(String path) =>
      jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

  group('daily tracks', () {
    for (final path in [
      'assets/content/daily_prepare.json',
      'assets/content/daily_seek.json',
    ]) {
      test('$path parses and is well-formed', () {
        final track = Track.fromJson(readJson(path));
        expect(track.days, isNotEmpty);
        for (final (i, day) in track.days.indexed) {
          expect(day.day, i + 1, reason: 'days must be sequential from 1');
          expect(day.title, isNotEmpty);
          expect(day.prayer, isNotEmpty);
          expect(day.reflection, isNotEmpty);
          expect(day.scriptureRef, isNotEmpty);
          expect(day.scriptureText, isNotEmpty);
          expect(day.closing, isNotEmpty);
        }
      });
    }
  });

  group('novenas', () {
    test('St. Raphael novena has exactly 9 sequential days', () {
      final novena =
          Novena.fromJson(readJson('assets/content/novena_raphael.json'));
      expect(novena.days.length, 9);
      for (final (i, day) in novena.days.indexed) {
        expect(day.day, i + 1);
        expect(day.prayer, isNotEmpty);
        expect(day.title, isNotEmpty);
      }
      expect(novena.saint, isNotEmpty);
      expect(novena.about, isNotEmpty);
    });
  });
}
