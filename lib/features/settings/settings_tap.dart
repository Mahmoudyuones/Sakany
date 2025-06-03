import 'package:flutter/material.dart';
import 'package:sakany/core/resources/color_manager.dart';
import 'package:sakany/core/resources/font_manager.dart';
import 'package:sakany/core/resources/style_manager.dart';
import 'package:sakany/features/auth/presentation/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool isDarkMode = false;
  bool isNotificationsEnabled = true;
  String selectedLanguage = 'English';

  Future<void> _logout() async {
    // Show confirmation dialog
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirm Logout'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'Cancel',
                  style: getBoldStyle(
                    color: ColorManager.primaryColor,
                    fontSize: FontSize.s16,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  'Logout',
                  style: getBoldStyle(
                    color: ColorManager.primaryColor,
                    fontSize: FontSize.s16,
                  ),
                ),
              ),
            ],
          ),
    );

    // Proceed only if user confirms
    if (confirm != true) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      // Selectively clear authentication-related keys
      await prefs.remove('userId');
      await prefs.remove('token');

      // Navigate to login screen
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);

      // Show feedback after navigation
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Successfully logged out')));
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error logging out: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Settings',
          style: getBoldStyle(
            color: ColorManager.black,
            fontSize: FontSize.s24,
          ),
        ),
        const SizedBox(height: 20),

        // Dark mode toggle
        SwitchListTile(
          title: Text(
            'Dark Mode',
            style: getBoldStyle(
              color: ColorManager.primaryColor,
              fontSize: FontSize.s18,
            ),
          ),
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
          title: Text(
            'Language',
            style: getBoldStyle(
              color: ColorManager.primaryColor,
              fontSize: FontSize.s18,
            ),
          ),
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
          title: Text(
            'About App',
            style: getBoldStyle(
              color: ColorManager.primaryColor,
              fontSize: FontSize.s18,
            ),
          ),
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
          title: Text(
            'Logout',
            style: getBoldStyle(
              color: ColorManager.primaryColor,
              fontSize: FontSize.s18,
            ),
          ),
          onTap: _logout,
        ),
      ],
    );
  }
}
