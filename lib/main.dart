import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_state.dart';
import 'screens/main_shell.dart';
import 'screens/welcome_screen.dart';
import 'services/content_service.dart';
import 'services/storage_service.dart';
import 'utils/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await StorageService.create();
  final state = AppState(storage, ContentService());
  await state.load();
  runApp(PrayludeApp(state: state));
}

class PrayludeApp extends StatelessWidget {
  final AppState state;
  const PrayludeApp({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: state,
      child: MaterialApp(
        title: 'Praylude',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: Consumer<AppState>(
          builder: (context, app, _) =>
              app.onboarded ? const MainShell() : const WelcomeScreen(),
        ),
      ),
    );
  }
}
