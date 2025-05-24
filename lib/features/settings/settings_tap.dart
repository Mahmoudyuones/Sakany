import 'package:flutter/material.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool isDarkMode = false;
  bool isNotificationsEnabled = true;
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Settings',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        // Notifications toggle
        SwitchListTile(
          title: const Text('Enable Notifications'),
          value: isNotificationsEnabled,
          onChanged: (val) {
            setState(() {
              isNotificationsEnabled = val;
            });
          },
        ),

        // Dark mode toggle
        SwitchListTile(
          title: const Text('Dark Mode'),
          value: isDarkMode,
          onChanged: (val) {
            setState(() {
              isDarkMode = val;
            });
          },
        ),

        const Divider(height: 40),

        // Language switcher
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('Language'),
          trailing: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedLanguage = newValue;
                  });
                }
              },
              items: const [
                DropdownMenuItem(value: 'English', child: Text('English')),
                DropdownMenuItem(value: 'Arabic', child: Text('Arabic')),
              ],
            ),
          ),
        ),

        const Divider(height: 40),

        // About
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('About App'),
          onTap: () {
            showAboutDialog(
              context: context,
              applicationName: 'Sakany',
              applicationVersion: '1.0.0',
              applicationLegalese: '© 2025 Sakany Team',
            );
          },
        ),

        // Logout
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Logged out')));
          },
        ),
      ],
    );
  }
}
