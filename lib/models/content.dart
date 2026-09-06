/// Content models — mirror the JSON schema in assets/content/.
/// The schema is the contract with the content writers; changes here
/// must stay in sync with the JSON files and the validation tests.
library;

enum ContentType { devotional, reflection, formation }

ContentType contentTypeFrom(String s) => switch (s) {
      'devotional' => ContentType.devotional,
      'reflection' => ContentType.reflection,
      'formation' => ContentType.formation,
      _ => throw FormatException('Unknown content type: $s'),
    };

class DailyEntry {
  final int day;
  final ContentType type;
  final String title;
  final String scriptureRef;
  final String scriptureText;
  final String prayer;
  final String reflection;
  final String closing;

  const DailyEntry({
    required this.day,
    required this.type,
    required this.title,
    required this.scriptureRef,
    required this.scriptureText,
    required this.prayer,
    required this.reflection,
    required this.closing,
  });

  factory DailyEntry.fromJson(Map<String, dynamic> json) => DailyEntry(
        day: json['day'] as int,
        type: contentTypeFrom(json['type'] as String),
        title: json['title'] as String,
        scriptureRef: json['scripture_ref'] as String,
        scriptureText: json['scripture_text'] as String,
        prayer: json['prayer'] as String,
        reflection: json['reflection'] as String,
        closing: json['closing'] as String,
      );
}

class Track {
  final String id; // 'prepare' | 'seek'
  final String title;
  final List<DailyEntry> days;

  const Track({required this.id, required this.title, required this.days});

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        id: json['track'] as String,
        title: json['title'] as String,
        days: (json['days'] as List)
            .map((d) => DailyEntry.fromJson(d as Map<String, dynamic>))
            .toList(),
      );
}

class Novena {
  final String id; // e.g. 'st-raphael'
  final String saint;
  final String title;
  final String subtitle;
  final String about;
  final List<DailyEntry> days;

  const Novena({
    required this.id,
    required this.saint,
    required this.title,
    required this.subtitle,
    required this.about,
    required this.days,
  });

  factory Novena.fromJson(Map<String, dynamic> json) => Novena(
        id: json['novena'] as String,
        saint: json['saint'] as String,
        title: json['title'] as String,
        subtitle: json['subtitle'] as String,
        about: json['about'] as String,
        days: (json['days'] as List)
            .map((d) => DailyEntry.fromJson(d as Map<String, dynamic>))
            .toList(),
      );
}
