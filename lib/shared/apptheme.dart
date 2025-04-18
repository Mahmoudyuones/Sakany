import 'package:flutter/material.dart';

class Apptheme {
  static const Color primaryColor = Color(0xff75C2FF);
  static const Color backGroundColor = Color(0xffFAF0CA);
  static const Color white = Color(0xffffffff);
  static const Color gray = Color(0xffAEAEAE);
  static const Color hintTextColor = Color.fromARGB(255, 146, 133, 133);
  static const Color darkGray = Color(0xffF8F8F8);
  static const Color black = Color(0xff000000);
  static const Color textColor = Color(0xff1E1E1E);
  static const Color lightblue = Color(0xff0D3B66);
  static const Color red = Color(0xffFF0101);
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: backGroundColor,
    ),
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backGroundColor,
    textTheme: TextTheme(
      titleSmall: TextStyle(
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        color: white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),

      titleLarge: TextStyle(
        color: textColor,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData();
}
