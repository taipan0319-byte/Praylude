import 'package:flutter/material.dart';

import 'novenas_screen.dart';
import 'record_screen.dart';
import 'settings_screen.dart';
import 'today_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const _screens = [
    TodayScreen(),
    NovenasScreen(),
    RecordScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.wb_sunny_outlined), label: 'Today'),
          NavigationDestination(
              icon: Icon(Icons.auto_awesome_outlined), label: 'Novenas'),
          NavigationDestination(
              icon: Icon(Icons.favorite_outline), label: 'Record'),
          NavigationDestination(
              icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      ),
    );
  }
}
