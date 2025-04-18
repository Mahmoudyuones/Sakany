import 'package:flutter/material.dart';
import 'package:sakany/auth/register_screen.dart';
import 'package:sakany/shared/widgets/default_eleveted_botton.dart';

class LandingPage extends StatelessWidget {
  static const String routeName = '/landing_page';
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/images/Gallery.png'),
              Text('Welcome!', style: Theme.of(context).textTheme.titleLarge),
              DefaultElevetedBotton(
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
