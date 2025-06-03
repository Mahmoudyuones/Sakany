import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakany/core/resources/color_manager.dart';
import 'package:sakany/features/add_apartment_screen.dart';
import 'package:sakany/features/home/home_tap.dart';
import 'package:sakany/features/proile/profile_tap.dart';
import 'package:sakany/features/services/services_tap.dart';
import 'package:sakany/features/settings/settings_tap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? userRole;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  void _loadUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getInt('userRole');
    });
  }

  List<Widget> screens = [
    HomeTap(),
    ServicesTap(),
    ProfileTab(),
    SettingsTab(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorManager.primaryColor,
          ),
          child: Icon(Icons.home, size: 40.sp, color: ColorManager.white),
        ),
      ),
      body: screens[currentIndex],
      floatingActionButton:
          userRole ==
                  1 // show only for owners
              ? FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddApartmentScreen.routeName);
                },
                backgroundColor: ColorManager.white,
                child: Icon(Icons.add),
              )
              : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorManager.white,
        selectedItemColor: ColorManager.primaryColor,
        unselectedItemColor: ColorManager.gray,

        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'Services',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
