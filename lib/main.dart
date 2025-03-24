import 'package:flutter/material.dart';
import 'package:sakany/apptheme.dart';
import 'package:sakany/auth/login_screen.dart';
import 'package:sakany/auth/register_screen.dart';
import 'package:sakany/auth/user_profile_form.dart';
import 'package:sakany/auth/verfication_screen.dart';
import 'package:sakany/home/home_screen.dart';
import 'package:sakany/landing_page.dart';

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
        VerficationScreen.routeName: (_) => VerficationScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        UserProfileForm.routeName: (_) => UserProfileForm(),
      },
      initialRoute: UserProfileForm.routeName,
      darkTheme: Apptheme.darkTheme,
      theme: Apptheme.lightTheme,
      themeMode: ThemeMode.light,
    );
  }
}
