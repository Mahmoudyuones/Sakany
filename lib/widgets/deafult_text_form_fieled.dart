import 'package:flutter/material.dart';
import 'package:sakany/apptheme.dart';

class DeafultTextFormFieled extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final String label;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextEditingController controller;
  const DeafultTextFormFieled({
    super.key,
    required this.hintText,
    required this.icon,
    required this.label,
    this.validator,
    required this.isPassword,
    required this.controller,
  });

  @override
  State<DeafultTextFormFieled> createState() => _DeafultTextFormFieledState();
}

class _DeafultTextFormFieledState extends State<DeafultTextFormFieled> {
  late bool isObscure = widget.isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      obscureText: isObscure,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(color: Apptheme.textColor),
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
                    color: Apptheme.hintTextColor,
                  ),
                )
                : null,
        prefixIcon: Icon(widget.icon, color: Apptheme.hintTextColor),
        filled: true,
        fillColor: Apptheme.darkGray,
        hintStyle: TextStyle(color: Apptheme.hintTextColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Apptheme.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Apptheme.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Apptheme.red),
        ),
      ),
    );
  }
}
