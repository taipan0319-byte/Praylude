import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/content.dart';
import '../providers/app_state.dart';
import '../utils/app_theme.dart';
import '../widgets/entry_view.dart';

class NovenasScreen extends StatelessWidget {
  const NovenasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Novenas')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final n in app.novenas) _NovenaCard(novena: n),
          const SizedBox(height: 12),
          Text(
            'St. Joseph and St. Anne novenas are coming next.',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppTheme.inkSoft),
          ),
        ],
      ),
    );
  }
}

class _NovenaCard extends StatelessWidget {
  final Novena novena;
  const _NovenaCard({required this.novena});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final started = app.novenaStarted(novena.id);
    final finished = app.novenaFinished(novena);
    final done = app.novenaCompletedDays(novena.id);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => NovenaDetailScreen(novena: novena)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(novena.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(novena.subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppTheme.inkSoft)),
              const SizedBox(height: 12),
              if (started) ...[
                LinearProgressIndicator(
                  value: done / novena.days.length,
                  color: AppTheme.candleGold,
                  backgroundColor: AppTheme.cream,
                  minHeight: 8,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                const SizedBox(height: 8),
                Text(
                  finished
                      ? 'Novena complete — well prayed.'
                      : 'Day ${app.novenaCurrentDay(novena)} of ${novena.days.length}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ] else
                Text('${novena.days.length} days · not started',
                    style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

class NovenaDetailScreen extends StatelessWidget {
  final Novena novena;
  const NovenaDetailScreen({super.key, required this.novena});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final started = app.novenaStarted(novena.id);
    final finished = app.novenaFinished(novena);

    return Scaffold(
      appBar: AppBar(title: Text(novena.saint)),
      body: !started
          ? _intro(context)
          : finished
              ? _finished(context)
              : _currentDay(context, app),
    );
  }

  Widget _intro(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(novena.title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(novena.subtitle,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppTheme.inkSoft)),
          const SizedBox(height: 20),
          Text(novena.about,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6)),
          const SizedBox(height: 20),
          Text(
            'Nine days of prayer. If you miss a day, you simply pray the next one when you return — a novena here is never broken, only paused.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppTheme.inkSoft, height: 1.5),
          ),
          const SizedBox(height: 28),
          FilledButton(
            onPressed: () => context.read<AppState>().startNovena(novena),
            child: const Text('Begin the novena'),
          ),
        ],
      ),
    );
  }

  Widget _currentDay(BuildContext context, AppState app) {
    final day = app.novenaCurrentDay(novena);
    final entry = novena.days[day - 1];
    return EntryView(
      entry: entry,
      header: '${novena.title} · Day $day of ${novena.days.length}',
      completeLabel: 'Amen — complete day $day',
      onComplete: () => context.read<AppState>().completeNovenaDay(novena),
    );
  }

  Widget _finished(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🕯️', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 16),
            Text('Nine days, faithfully prayed.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text('${novena.saint}, continue to intercede.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppTheme.inkSoft)),
          ],
        ),
      ),
    );
  }
}
