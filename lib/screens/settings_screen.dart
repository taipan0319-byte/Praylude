import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import '../utils/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('DAILY PRAYER PATH',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: AppTheme.inkSoft, letterSpacing: 1.2)),
          const SizedBox(height: 8),
          for (final (value, label) in [
            ('both', 'Both paths'),
            ('prepare', 'Prepare — patient discernment'),
            ('seek', 'Seek — asking boldly'),
          ])
            RadioListTile<String>(
              value: value,
              groupValue: app.trackPreference,
              onChanged: (v) =>
                  context.read<AppState>().setTrackPreference(v!),
              title: Text(label),
              activeColor: AppTheme.ember,
            ),
          const Divider(height: 32),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Daily reminder'),
            subtitle:
                const Text('Coming with the iPhone build (TestFlight).'),
            enabled: false,
          ),
          const Divider(height: 32),
          ListTile(
            leading: const Icon(Icons.restart_alt, color: AppTheme.ember),
            title: const Text('Reset prototype data'),
            subtitle: const Text('Clears all progress. For testing.'),
            onTap: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Reset everything?'),
                  content: const Text(
                      'All progress and preferences will be cleared.'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Cancel')),
                    FilledButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Reset')),
                  ],
                ),
              );
              if (confirmed == true && context.mounted) {
                await context.read<AppState>().resetAll();
              }
            },
          ),
          const SizedBox(height: 24),
          Center(
            child: Text('Praylude · prototype v0.1',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppTheme.inkSoft)),
          ),
        ],
      ),
    );
  }
}
