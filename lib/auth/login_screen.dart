import 'package:flutter/material.dart';
import 'package:sakany/auth/register_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login_screen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('Register'),
          onPressed: () {
            Navigator.of(
              context,
            ).pushReplacementNamed(RegisterScreen.routeName);
          },
        ),
      ),
    );
  }
}
