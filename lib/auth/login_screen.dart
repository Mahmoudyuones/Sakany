import 'package:flutter/material.dart';
import 'package:sakany/auth/register_screen.dart';
import 'package:sakany/home/home_screen.dart';
import 'package:sakany/shared/app_validator.dart';
import 'package:sakany/shared/widgets/default_eleveted_botton.dart';
import 'package:sakany/shared/widgets/default_text_form_fieled.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextTheme.of(context).titleLarge!.copyWith(fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 40),
              DefaultTextFormFieled(
                hintText: 'Enter your email',
                icon: Icons.email,
                label: 'Email',
                isPassword: false,
                controller: nameController,
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
              DefaultTextFormFieled(
                hintText: 'Enter password',
                icon: Icons.lock,
                label: 'Password',
                isPassword: true,
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Password can not be empty';
                  } else if (value.trim().length < 6) {
                    return 'PassWord Must be atleast 6 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              DefaultElevetedBotton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(HomeScreen.routeName);
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
    );
  }
}
