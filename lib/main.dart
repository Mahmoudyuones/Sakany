import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakany/core/app_bloc_observer.dart';
import 'package:sakany/features/auth/presentation/screens/login_screen.dart';
import 'package:sakany/features/auth/presentation/screens/register_screen.dart';
import 'package:sakany/features/auth/presentation/screens/user_profile_form_screen.dart';
import 'package:sakany/features/auth/presentation/screens/verification_screen.dart';
import 'package:sakany/features/home/home_screen.dart';
import 'package:sakany/features/auth/presentation/screens/landing_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  runApp(const SakanyApp());
}

class SakanyApp extends StatelessWidget {
  const SakanyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 900),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (_, __) => MaterialApp(
            routes: {
              LandingPage.routeName: (_) => const LandingPage(),
              RegisterScreen.routeName: (_) => const RegisterScreen(),
              LoginScreen.routeName: (_) => LoginScreen(),
              VerificationScreen.routeName: (_) => VerificationScreen(),
              HomeScreen.routeName: (_) => HomeScreen(),
              UserProfileFormScreen.routeName: (_) => UserProfileFormScreen(),
            },
            initialRoute: LandingPage.routeName,
          ),
    );
  }
}
