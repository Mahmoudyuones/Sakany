import 'package:flutter/material.dart';
import 'package:sakany/auth/view/screens/login_screen.dart';
import 'package:sakany/auth/view/screens/verification_screen.dart';
import 'package:sakany/shared/app_validator.dart';
import 'package:sakany/shared/apptheme.dart';
import 'package:sakany/shared/widgets/default_elevated_button.dart';
import 'package:sakany/shared/widgets/default_text_form_field.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppTheme.primaryColor,
                        ),
                        child: Icon(
                          Icons.home,
                          size: 40,
                          color: AppTheme.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Sakany',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 10),
                      Text('Create your account to fine perfect student home'),
                      SizedBox(height: 30),
                      DefaultTextFormField(
                        hintText: 'Enter your username',
                        icon: Icons.person_2_outlined,
                        label: "Username",
                        isPassword: false,
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      DefaultTextFormField(
                        hintText: 'Enter your email',
                        icon: Icons.email_outlined,
                        label: 'Email',
                        isPassword: false,
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email can not be empty';
                          } else if (!AppValidator.isEmailValid(value)) {
                            return "Invalid Email format";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      DefaultTextFormField(
                        hintText: 'Enter your Password',
                        icon: Icons.lock,
                        label: "Password",
                        isPassword: true,
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.trim().length < 6) {
                            return 'Password can not be less than 6 character';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      DefaultTextFormField(
                        hintText: 'Rewrite your Password',
                        icon: Icons.lock,
                        label: "Confirm Password",
                        isPassword: true,
                        controller: rePasswordController,
                        validator: (value) {
                          if (value != passwordController.text) {
                            return 'Password does not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 40),
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
                                height: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
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

                      DefaultElevatedButton(
                        onPressed: () {},
                        text: "Sign up with Google",
                        backGroundColor: AppTheme.white,
                        textColor: AppTheme.black,
                        icon: Icons.g_mobiledata,
                      ),
                      SizedBox(height: 20),
                      DefaultElevatedButton(
                        onPressed: () {},
                        text: "Sign up with Facebook",
                        backGroundColor: AppTheme.white,
                        textColor: AppTheme.black,
                        icon: Icons.facebook,
                      ),
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
                          ).titleSmall!.copyWith(fontSize: 16),
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
