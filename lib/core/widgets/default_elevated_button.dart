import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakany/core/resources/color_manager.dart';

class DefaultElevatedButton extends StatelessWidget {
  const DefaultElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backGroundColor,
    this.textColor = ColorManager.white,
    this.icon,
  });
  final VoidCallback onPressed;
  final String text;
  final Color? backGroundColor;
  final Color textColor;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backGroundColor ?? ColorManager.primaryColor,
        fixedSize: Size(MediaQuery.of(context).size.width, 50.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      child:
          icon == null
              ? Text(
                text,
                style: TextTheme.of(
                  context,
                ).titleMedium!.copyWith(color: textColor),
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: ColorManager.textColor, size: 20.sp),
                  SizedBox(width: 10.w),
                  Text(
                    text,
                    style: TextTheme.of(
                      context,
                    ).titleMedium!.copyWith(color: textColor),
                  ),
                ],
              ),
    );
  }
}
