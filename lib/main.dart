import 'package:flutter/material.dart';
import 'package:sakany/shared/apptheme.dart';
import 'package:sakany/auth/view/screens/login_screen.dart';
import 'package:sakany/auth/view/screens/register_screen.dart';
import 'package:sakany/auth/view/screens/user_profile_form_screen.dart';
import 'package:sakany/auth/view/screens/verification_screen.dart';
import 'package:sakany/home/home_screen.dart';
import 'package:sakany/auth/view/screens/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LandingPage.routeName: (_) => const LandingPage(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        VerificationScreen.routeName: (_) => VerificationScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        UserProfileFormScreen.routeName: (_) => UserProfileFormScreen(),
      },
      initialRoute: LandingPage.routeName,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
    );
  }
}
