import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import '../utils/app_theme.dart';

/// The faithfulness record. Leads with total days prayed; the streak is
/// secondary and a missed day is never described as a loss.
class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Faithfulness')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text('${app.totalDaysPrayed}',
                        style: text.displayMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppTheme.ember)),
                    Text(
                        app.totalDaysPrayed == 1
                            ? 'day of prayer'
                            : 'days of prayer',
                        style: text.titleMedium
                            ?.copyWith(color: AppTheme.inkSoft)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _stat(context, '🔥', '${app.currentStreak}',
                      'day rhythm'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _stat(context, app.prayedToday ? '✓' : '·',
                      app.prayedToday ? 'Prayed' : 'Not yet', 'today'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              app.totalDaysPrayed == 0
                  ? 'Your record begins with your first prayer. Today is a fine day for it.'
                  : 'Every day here is a day you showed up. If you miss one, you have lost nothing — simply return.',
              textAlign: TextAlign.center,
              style: text.bodyMedium
                  ?.copyWith(color: AppTheme.inkSoft, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(BuildContext context, String emoji, String value, String label) {
    final text = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 4),
            Text(value,
                style: text.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            Text(label,
                style: text.bodySmall?.copyWith(color: AppTheme.inkSoft)),
          ],
        ),
      ),
    );
  }
}
