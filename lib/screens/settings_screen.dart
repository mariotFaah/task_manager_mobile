import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen(
      {super.key, required this.isDark, required this.onThemeChanged});
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: ListView(padding: const EdgeInsets.all(24), children: [
          Text('Personalize TaskFlow',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 24),
          Card(
              child: SwitchListTile(
                  value: isDark,
                  onChanged: onThemeChanged,
                  title: const Text('Dark theme'),
                  subtitle: const Text('Adjust the app appearance'),
                  secondary: const Icon(Icons.dark_mode_outlined))),
          const SizedBox(height: 12),
          const Card(
              child: ListTile(
                  leading: Icon(Icons.notifications_none),
                  title: Text('Notifications'),
                  subtitle: Text('Reminders are enabled'))),
          const Card(
              child: ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('About TaskFlow'),
                  subtitle: Text('Version 1.0.0'))),
        ]),
      );
}
