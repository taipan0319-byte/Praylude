import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/content.dart';
import '../utils/app_theme.dart';
import '../widgets/entry_view.dart';
import '../providers/app_state.dart';

/// The day's prayer(s). With preference 'both', tracks appear as tabs.
class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final tracks = app.activeTracks;

    if (tracks.length == 1) {
      return Scaffold(
        appBar: AppBar(title: const Text('Today')),
        body: _trackBody(context, app, tracks.first),
      );
    }
    return DefaultTabController(
      length: tracks.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Today'),
          bottom: TabBar(
            labelColor: AppTheme.ember,
            indicatorColor: AppTheme.ember,
            tabs: [for (final t in tracks) Tab(text: _shortName(t))],
          ),
        ),
        body: TabBarView(
          children: [for (final t in tracks) _trackBody(context, app, t)],
        ),
      ),
    );
  }

  String _shortName(Track t) => t.id == 'prepare' ? 'Prepare' : 'Seek';

  Widget _trackBody(BuildContext context, AppState app, Track track) {
    if (app.trackFinished(track)) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            "You've prayed every day of ${track.title} so far.\nMore is being written — check back soon.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      );
    }
    final entry = app.currentEntry(track);
    return EntryView(
      entry: entry,
      header: '${track.title} · Day ${entry.day}',
      onComplete: () => context.read<AppState>().completeCurrentEntry(track),
    );
  }
}
