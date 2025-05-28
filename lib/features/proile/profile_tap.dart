import 'package:flutter/material.dart';
import 'package:sakany/features/auth/presentation/screens/user_profile_form_screen.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool isStudent = true;
  @override
  Widget build(BuildContext context) {
    return UserProfileFormScreen();
  }
}
