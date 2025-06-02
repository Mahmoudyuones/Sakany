import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakany/core/resources/color_manager.dart';

import 'package:sakany/core/widgets/default_elevated_button.dart';
import 'package:sakany/features/auth/presentation/screens/register_screen.dart';

class LandingPage extends StatefulWidget {
  static const String routeName = '/landing_page';

  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/image1.jpg',
      'title': 'Welcome to Sakany!',
      'subtitle':
          'Helping students find affordable, verified homes near university campuses.',
    },
    {
      'image': 'assets/images/image2.jpg',
      'title': 'Browse and Search with Ease',
      'subtitle':
          'Use filters to find apartments by price, distance, or type in seconds.',
    },
    {
      'image': 'assets/images/image3.jpg',
      'title': 'Only Verified Apartments',
      'subtitle':
          'Every listing is reviewed and approved to ensure safety and trust.',
    },
    {
      'image': 'assets/images/image4.jpg',
      'title': 'Have an apartment you want to rent ',
      'subtitle': 'You can post it easily so every student can see it',
    },
  ];

  void _goToNextPage() {
    if (_currentIndex < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skip() {
    Navigator.of(context).pushReplacementNamed(RegisterScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingData.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final data = onboardingData[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          data['image']!,
                          height: 500.h,
                          width: 300.w,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 30.h),
                        Text(
                          data['title']!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          data['subtitle']!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Buttons
              if (_currentIndex == onboardingData.length - 1)
                Padding(
                  padding: EdgeInsets.only(bottom: 40.h),
                  child: DefaultElevatedButton(
                    //   width: 200.w,
                    onPressed: _skip,
                    text: 'Get Started',
                  ),
                )
              else
                Padding(
                  padding: EdgeInsets.only(bottom: 40.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultElevatedButton(
                        backGroundColor: ColorManager.white,
                        textColor: ColorManager.black,
                        width: 150.w,
                        onPressed: _skip,
                        text: 'Skip',
                      ),
                      DefaultElevatedButton(
                        width: 150.w,
                        onPressed: _goToNextPage,
                        text: 'Next',
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
