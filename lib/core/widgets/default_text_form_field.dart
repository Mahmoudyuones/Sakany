import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakany/core/resources/color_manager.dart';

class DefaultTextFormField extends StatefulWidget {
  final String hintText;
  final IconData? icon;
  final String label;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextEditingController controller;
  const DefaultTextFormField({
    super.key,
    required this.hintText,
    this.icon,
    required this.label,
    this.validator,
    required this.isPassword,
    required this.controller,
  });

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  late bool isObscure = widget.isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      obscureText: isObscure,
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(color: ColorManager.textColor),
        hintText: widget.hintText,
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                    color: ColorManager.hintTextColor,
                  ),
                )
                : null,
        prefixIcon:
            widget.icon == null
                ? null
                : Icon(widget.icon, color: ColorManager.hintTextColor),
        filled: true,
        fillColor: ColorManager.white,
        hintStyle: TextStyle(color: ColorManager.hintTextColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: ColorManager.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: ColorManager.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: ColorManager.red),
        ),
      ),
    );
  }
}
