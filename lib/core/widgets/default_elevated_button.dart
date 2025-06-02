import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakany/core/resources/color_manager.dart';
import 'package:sakany/core/resources/font_manager.dart';
import 'package:sakany/core/resources/style_manager.dart' as StylesManager;

class DefaultElevatedButton extends StatelessWidget {
  const DefaultElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backGroundColor,
    this.textColor,
    this.icon,
    this.width,
  });
  final VoidCallback onPressed;
  final String text;
  final Color? backGroundColor;
  final Color? textColor;
  final IconData? icon;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: textColor != null ? BorderSide(color: textColor!) : null,
        backgroundColor: backGroundColor ?? ColorManager.primaryColor,
        fixedSize: Size(width ?? 358.w, 54.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Text(
        text,
        style: StylesManager.getBoldStyle(
          color: textColor ?? ColorManager.white,
          fontSize: FontSize.s16,
        ),
      ),
    );
  }
}
