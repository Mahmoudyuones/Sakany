import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakany/core/resources/color_manager.dart';
import 'package:sakany/core/resources/font_manager.dart';
import 'package:sakany/core/resources/style_manager.dart' as StylesManager;
import 'package:sakany/core/utils/validator.dart';
import 'package:sakany/features/auth/presentation/screens/login_screen.dart';
import 'package:sakany/features/auth/presentation/screens/verification_screen.dart';
import 'package:sakany/core/widgets/default_elevated_button.dart';
import 'package:sakany/core/widgets/default_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = '/register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: ColorManager.primaryColor,
                        ),
                        child: Icon(
                          Icons.home,
                          size: 40.sp,
                          color: ColorManager.white,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Sakany',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 10.h),
                      Text('Create your account to fine perfect student home'),
                      SizedBox(height: 30.h),
                      SizedBox(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: AnimatedToggleSwitch<int>.size(
                            textDirection: TextDirection.rtl,
                            current: selectedIndex,
                            values: const [0, 1],
                            iconOpacity: 1.0,
                            indicatorSize: Size(180.w, 50.h),
                            iconBuilder: (value) {
                              final isSelected = selectedIndex == value;
                              return Center(
                                child: Text(
                                  value == 0 ? 'Owner' : 'Student',
                                  style: StylesManager.getBoldStyle(
                                    color:
                                        isSelected
                                            ? ColorManager.white
                                            : ColorManager.primaryColor,
                                    fontSize: FontSize.s14,
                                  ),
                                ),
                              );
                            },
                            borderWidth: 0.0,
                            iconAnimationType: AnimationType.onHover,
                            style: ToggleStyle(
                              backgroundColor: ColorManager.backGroundColor,
                              borderRadius: BorderRadius.circular(15.r),
                              indicatorColor: ColorManager.primaryColor,
                            ),
                            onChanged: (i) {
                              setState(() {
                                selectedIndex = i;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      DefaultTextFormField(
                        hintText: 'Enter your username',
                        icon: Icons.person_2_outlined,
                        label: "Username",
                        isPassword: false,
                        controller: nameController,
                        validator: Validator.validateFullName,
                      ),
                      SizedBox(height: 20.h),
                      DefaultTextFormField(
                        hintText: 'Enter your email',
                        icon: Icons.email_outlined,
                        label: 'Email',
                        isPassword: false,
                        controller: emailController,
                        validator: Validator.validateEmail,
                      ),
                      SizedBox(height: 20),
                      DefaultTextFormField(
                        hintText: 'Enter your Password',
                        icon: Icons.lock,
                        label: "Password",
                        isPassword: true,
                        controller: passwordController,
                        validator: Validator.validatePassword,
                      ),
                      SizedBox(height: 20.h),
                      DefaultTextFormField(
                        hintText: 'Rewrite your Password',
                        icon: Icons.lock,
                        label: "Confirm Password",
                        isPassword: true,
                        controller: rePasswordController,
                        validator: (value) {
                          return Validator.validateConfirmPassword(
                            value,
                            passwordController.text,
                          );
                        },
                      ),

                      SizedBox(height: 40.h),
                      DefaultElevatedButton(
                        onPressed: register,
                        text: "Sign up",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.grey.shade600,
                                width: double.infinity,
                                height: 1.h,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Text('OR'),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.grey.shade600,
                                width: double.infinity,
                                height: 1.h,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // DefaultElevatedButton(
                      //   onPressed: () {},
                      //   text: "Sign up with Google",
                      //   backGroundColor: ColorManager.white,
                      //   textColor: ColorManager.black,
                      //   icon: Icons.g_mobiledata,
                      // ),
                      // SizedBox(height: 20.h),
                      // DefaultElevatedButton(
                      //   onPressed: () {},
                      //   text: "Sign up with Facebook",
                      //   backGroundColor: ColorManager.white,
                      //   textColor: ColorManager.black,
                      //   icon: Icons.facebook,
                      // ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushReplacementNamed(LoginScreen.routeName);
                        },
                        child: Text(
                          'Already have an account? Login',
                          style: TextTheme.of(
                            context,
                          ).titleSmall!.copyWith(fontSize: 16.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      Navigator.of(context).pushNamed(
        VerificationScreen.routeName,
        arguments: emailController.text,
      );
    }
  }
}
