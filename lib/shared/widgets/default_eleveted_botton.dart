import 'package:flutter/material.dart';
import 'package:sakany/shared/apptheme.dart';

class DefaultElevetedBotton extends StatelessWidget {
  const DefaultElevetedBotton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backGroundColor,
    this.textColor,
    this.icon,
  });
  final VoidCallback onPressed;
  final String text;
  final Color? backGroundColor;
  final Color? textColor;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backGroundColor ?? Apptheme.primaryColor,
        fixedSize: Size(MediaQuery.of(context).size.width, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                  Icon(icon, color: Apptheme.textColor, size: 20),
                  SizedBox(width: 10),
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
