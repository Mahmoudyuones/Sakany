import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:sakany/core/resources/color_manager.dart';
import 'package:sakany/features/auth/presentation/screens/user_profile_form_screen.dart';
import 'package:sakany/core/widgets/default_elevated_button.dart';

class VerificationScreen extends StatefulWidget {
  static const String routeName = '/verification';
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;

    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: TextStyle(
        fontSize: 22.sp,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19.r),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verification',
          style: TextTheme.of(context).titleLarge!.copyWith(fontSize: 20.sp),
        ),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  Container(
                    height: 122,
                    width: 122,
                    decoration: BoxDecoration(
                      color: ColorManager.darkGray,
                      borderRadius: BorderRadius.circular(122.r),
                    ),
                    child: Center(
                      child: Container(
                        height: 92.h,
                        width: 92.w,
                        decoration: BoxDecoration(
                          color: ColorManager.primaryColor,
                          borderRadius: BorderRadius.circular(92.r),
                        ),
                        child: Icon(
                          Icons.lock,
                          color: ColorManager.white,
                          size: 33.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Verification Code',
                    style: TextTheme.of(
                      context,
                    ).titleLarge!.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    'We have sent the code to',
                    style: TextTheme.of(
                      context,
                    ).titleSmall!.copyWith(color: ColorManager.textColor),
                  ),
                  Text(
                    email, // Should always be valid
                    style: TextTheme.of(context).titleLarge!.copyWith(
                      fontSize: 16.sp,
                      color: ColorManager.textColor,
                    ),
                  ),
                  SizedBox(height: 60.h),
                  Pinput(
                    length: 6,
                    controller: pinController,
                    focusNode: focusNode,
                    defaultPinTheme: defaultPinTheme,
                    separatorBuilder: (index) => SizedBox(width: 8.w),
                    validator: (value) {
                      return value == '222222' ? null : 'Pin is incorrect';
                    },
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: fillColor,
                        borderRadius: BorderRadius.circular(19.r),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.redAccent),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  DefaultElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        focusNode.unfocus();
                        Navigator.of(
                          context,
                        ).pushReplacementNamed(UserProfileFormScreen.routeName);
                      }
                    },
                    text: 'Submit',
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Didn’t receive the code? Resend it',
                      style: TextTheme.of(context).titleSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
