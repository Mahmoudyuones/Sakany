import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakany/features/auth/presentation/screens/register_screen.dart';
import 'package:sakany/core/widgets/default_elevated_button.dart';

class LandingPage extends StatelessWidget {
  static const String routeName = '/landing_page';
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/images/Gallery.png'),
              Text('Welcome!', style: Theme.of(context).textTheme.titleLarge),
              DefaultElevatedButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(RegisterScreen.routeName);
                },
                text: 'Get Started',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
