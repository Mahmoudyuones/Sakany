import 'package:flutter/material.dart';
import 'package:sakany/features/auth/presentation/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('Home Screen'),
          onPressed:
              () => Navigator.of(
                context,
              ).pushReplacementNamed(LoginScreen.routeName),
        ),
      ),
    );
  }
}
