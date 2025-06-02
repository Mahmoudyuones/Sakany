import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakany/core/resources/color_manager.dart';
import 'package:sakany/core/utils/validator.dart';
import 'package:sakany/features/auth/presentation/screens/register_screen.dart';
import 'package:sakany/core/widgets/default_elevated_button.dart';
import 'package:sakany/core/widgets/default_text_form_field.dart';
import 'package:sakany/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      borderRadius: BorderRadius.circular(8),
                      color: ColorManager.primaryColor,
                    ),
                    child: Icon(
                      Icons.home,
                      size: 40.sp,
                      color: ColorManager.white,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text('Sakany', style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 40.h),
                  DefaultTextFormField(
                    hintText: 'Enter your email',
                    icon: Icons.email,
                    label: 'Email',
                    isPassword: false,
                    controller: emailController,
                    validator: Validator.validateEmail,
                  ),
                  SizedBox(height: 20.h),
                  DefaultTextFormField(
                    hintText: 'Enter password',
                    icon: Icons.lock,
                    label: 'Password',
                    isPassword: true,
                    controller: passwordController,
                    validator: Validator.validatePassword,
                  ),
                  SizedBox(height: 20.h),
                  DefaultElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();

                        final dio = Dio();
                        final url =
                            'https://creative-endlessly-bullfrog.ngrok-free.app/api/Auth/login';

                        try {
                          final response = await dio.post(
                            url,
                            data: {
                              'email': emailController.text.trim(),
                              'password': passwordController.text.trim(),
                            },
                            options: Options(
                              headers: {'Content-Type': 'application/json'},
                            ),
                          );

                          if (response.statusCode == 200) {
                            final data = response.data;
                            final token = data['token'];
                            if (data['success'] == true) {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString('token', token);

                              Navigator.of(
                                context,
                              ).pushReplacementNamed(HomeScreen.routeName);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    data['message'] ?? 'Login failed',
                                  ),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Login failed. Try again later.'),
                              ),
                            );
                          }
                        } on DioError catch (e) {
                          String errorMessage =
                              'Unexpected error. Please check your connection.';
                          if (e.type == DioErrorType.connectionTimeout ||
                              e.type == DioErrorType.sendTimeout ||
                              e.type == DioErrorType.receiveTimeout) {
                            errorMessage =
                                'Connection timed out. Please try again.';
                          } else if (e.type == DioErrorType.badResponse) {
                            errorMessage = 'Invalid email or password.';
                          } else if (e.type == DioErrorType.unknown) {
                            errorMessage =
                                'Server is unreachable. Check your internet or server.';
                          }

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(errorMessage)));
                        }
                      }
                    },

                    text: 'Login',
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot password ?',
                      style: TextTheme.of(context).titleSmall,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.grey.shade600,
                            width: double.infinity,
                            height: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.h),
                          child: Text('OR'),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.grey.shade600,
                            width: double.infinity,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // DefaultElevatedButton(
                  // //   onPressed: () {},
                  // //   text: "Login with Google",
                  // //   backGroundColor: ColorManager.white,
                  // //   textColor: ColorManager.black,
                  // //   icon: Icons.g_mobiledata,
                  // // ),
                  // // SizedBox(height: 20.h),
                  // // DefaultElevatedButton(
                  // //   onPressed: () {},
                  // //   text: "Login with Facebook",
                  // //   backGroundColor: ColorManager.white,
                  // //   textColor: ColorManager.black,
                  // //   icon: Icons.facebook,
                  // // ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(RegisterScreen.routeName);
                    },
                    child: Text(
                      'Don\'t have an account? Create an account',
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
