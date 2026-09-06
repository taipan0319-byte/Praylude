# Praylude

A Catholic devotional app for those seeking the vocation of marriage.
**Not a dating app** — no matching, no profiles, no messaging. A daily prayer
companion: traditional substance, contemporary doorway.

> "You haven't met them yet. You can still pray for them."

Built with Flutter (iOS + Android + web preview, single codebase). Local-first:
all content ships inside the app and all progress stays on the device.

## Current state — Milestone 1: "First Novena"

- Welcome / soft track choice (Prepare · Seek · Both — switchable anytime)
- Today screen with the day's prayer + reflection (sequence model: you're
  always on your next incomplete day; missing days never resets anything)
- St. Raphael novena: saint intro, day N of 9, progress saved
- Faithfulness record: total days prayed first, streak second, no guilt
- Content is **placeholder text** pending the real writing (see schema below)

Not yet: reminders/notifications (needs the native iPhone build), letters
journal, St. Joseph / St. Anne novenas.

## Web preview

Every push to `main` builds the web version and deploys it to GitHub Pages
via `.github/workflows/deploy-web.yml`. One-time setup: repo **Settings →
Pages → Source: GitHub Actions**.

The preview is for evaluating writing, look, and navigation. Reminders and
storage durability can only be judged in the native iPhone build (TestFlight),
which is a later milestone.

## Local development

1. Install Flutter (3.x): https://docs.flutter.dev/get-started/install
2. Generate platform folders (safe — never overwrites app code):
   `flutter create . --project-name praylude --org com.praylude`
3. `flutter pub get`, then `flutter run`
4. `flutter test` validates the content files and app logic.

## Content schema

Content lives in `assets/content/` as JSON. Each day:

```json
{
  "day": 1,
  "type": "devotional | reflection | formation",
  "title": "...",
  "scripture_ref": "Psalm 26:14 (Douay-Rheims)",
  "scripture_text": "...",
  "prayer": "...",
  "reflection": "Paragraphs separated by blank lines.",
  "closing": "..."
}
```

Tracks (`daily_prepare.json`, `daily_seek.json`) hold a `days` array; novenas
(`novena_*.json`) add `saint`, `subtitle`, `about` and exactly 9 days.
Scripture is Douay-Rheims (public domain). `flutter test` rejects malformed
content, so writers can edit these files directly and CI catches mistakes.
