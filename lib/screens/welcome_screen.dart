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
              const SizedBox(height: 12),
              Text(
                "You haven't met them yet.\nYou can still pray for them.",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600, height: 1.3),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    Text(
                      '“Ask and it will be given to you.”',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: AppTheme.ember,
                              height: 1.4),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Matthew 7:7',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(
                              color: AppTheme.inkSoft, letterSpacing: 1.1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Bring your hope for marriage to God. Pray for your future spouse, ask for the grace to meet, and prepare to build a faithful life together.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppTheme.inkSoft, height: 1.6),
              ),
              const SizedBox(height: 28),
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
                child: const Text('Begin praying'),
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
