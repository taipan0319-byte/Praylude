import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import '../utils/app_theme.dart';

/// Minimal onboarding. Track choice is deliberately soft — "both" is the
/// default and switching later is free (Settings).
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String _pref = 'both';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Scroll-safe: fills tall screens with spacers, scrolls on short ones
        // instead of overflowing.
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(),
              const Text('🕯️', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 56)),
              const SizedBox(height: 16),
              Text('Praylude',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text(
                "You haven't met them yet.\nYou can still pray for them.",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppTheme.inkSoft),
              ),
              const SizedBox(height: 40),
              Text('How would you like to begin?',
                  style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 12),
              _choice('both', 'A bit of everything',
                  'Daily prayers from both paths — you can narrow later.'),
              _choice('prepare', 'Prepare',
                  'Patient discernment. Becoming ready.'),
              _choice('seek', 'Seek',
                  'Boldly asking God to bring you your spouse.'),
              const Spacer(),
              FilledButton(
                onPressed: () =>
                    context.read<AppState>().completeOnboarding(_pref),
                child: const Text('Begin'),
              ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _choice(String value, String title, String subtitle) {
    final selected = _pref == value;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
            color: selected ? AppTheme.ember : Colors.transparent, width: 2),
      ),
      child: ListTile(
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: selected
            ? const Icon(Icons.check_circle, color: AppTheme.ember)
            : null,
        onTap: () => setState(() => _pref = value),
      ),
    );
  }
}
