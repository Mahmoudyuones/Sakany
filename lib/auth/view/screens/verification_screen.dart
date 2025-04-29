import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sakany/shared/apptheme.dart';
import 'package:sakany/auth/view/screens/user_profile_form_screen.dart';
import 'package:sakany/shared/widgets/default_elevated_button.dart';

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
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verification',
          style: TextTheme.of(context).titleLarge!.copyWith(fontSize: 20),
        ),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    height: 122,
                    width: 122,
                    decoration: BoxDecoration(
                      color: AppTheme.darkGray,
                      borderRadius: BorderRadius.circular(122),
                    ),
                    child: Center(
                      child: Container(
                        height: 92,
                        width: 92,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(92),
                        ),
                        child: Icon(
                          Icons.lock,
                          color: AppTheme.white,
                          size: 33,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Verification Code',
                    style: TextTheme.of(
                      context,
                    ).titleLarge!.copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'We have sent the code to',
                    style: TextTheme.of(
                      context,
                    ).titleSmall!.copyWith(color: AppTheme.textColor),
                  ),
                  Text(
                    email, // Should always be valid
                    style: TextTheme.of(context).titleLarge!.copyWith(
                      fontSize: 16,
                      color: AppTheme.textColor,
                    ),
                  ),
                  SizedBox(height: 60),
                  Pinput(
                    length: 6,
                    controller: pinController,
                    focusNode: focusNode,
                    defaultPinTheme: defaultPinTheme,
                    separatorBuilder: (index) => const SizedBox(width: 8),
                    validator: (value) {
                      return value == '222222' ? null : 'Pin is incorrect';
                    },
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: fillColor,
                        borderRadius: BorderRadius.circular(19),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.redAccent),
                    ),
                  ),
                  SizedBox(height: 20),
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
