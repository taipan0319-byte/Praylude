import 'package:flutter/material.dart';

import '../models/content.dart';
import '../utils/app_theme.dart';

/// Renders one day's content — shared by Today and novena screens.
class EntryView extends StatelessWidget {
  final DailyEntry entry;
  final String? header; // e.g. track title or "Day 3 of 9"
  final bool completed;
  final VoidCallback? onComplete;
  final String completeLabel;

  const EntryView({
    super.key,
    required this.entry,
    this.header,
    this.completed = false,
    this.onComplete,
    this.completeLabel = 'Amen — prayed today',
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null) ...[
            Text(header!.toUpperCase(),
                style: text.labelMedium?.copyWith(
                    color: AppTheme.inkSoft, letterSpacing: 1.2)),
            const SizedBox(height: 6),
          ],
          Row(
            children: [
              _TypeChip(type: entry.type),
              const Spacer(),
              if (completed)
                const Icon(Icons.check_circle, color: AppTheme.candleGold),
            ],
          ),
          const SizedBox(height: 10),
          Text(entry.title,
              style: text.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry.scriptureText,
                      style: text.bodyLarge?.copyWith(
                          fontStyle: FontStyle.italic, height: 1.5)),
                  const SizedBox(height: 8),
                  Text('— ${entry.scriptureRef}',
                      style: text.bodySmall
                          ?.copyWith(color: AppTheme.inkSoft)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _section(context, 'Pray', entry.prayer),
          _section(context, 'Reflect', entry.reflection),
          const SizedBox(height: 8),
          Center(
            child: Text(entry.closing,
                textAlign: TextAlign.center,
                style: text.titleSmall?.copyWith(
                    fontStyle: FontStyle.italic, color: AppTheme.ember)),
          ),
          const SizedBox(height: 28),
          if (onComplete != null && !completed)
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onComplete,
                child: Text(completeLabel),
              ),
            ),
          if (completed)
            Center(
              child: Text('Prayed. Well done, faithful one.',
                  style: text.bodyMedium?.copyWith(color: AppTheme.inkSoft)),
            ),
        ],
      ),
    );
  }

  Widget _section(BuildContext context, String label, String body) {
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(),
              style: text.labelMedium
                  ?.copyWith(color: AppTheme.candleGold, letterSpacing: 1.2)),
          const SizedBox(height: 6),
          Text(body, style: text.bodyLarge?.copyWith(height: 1.6)),
        ],
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  final ContentType type;
  const _TypeChip({required this.type});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (type) {
      ContentType.devotional => ('Devotional', AppTheme.ember),
      ContentType.reflection => ('Reflection', AppTheme.nightBlue),
      ContentType.formation => ('Formation', AppTheme.candleGold),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: color)),
    );
  }
}
