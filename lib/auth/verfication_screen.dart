import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sakany/apptheme.dart';
import 'package:sakany/auth/user_profile_form.dart';
import 'package:sakany/widgets/default_eleveted_botton.dart';

class VerficationScreen extends StatefulWidget {
  static const String routeName = '/verification';
  const VerficationScreen({super.key});

  @override
  State<VerficationScreen> createState() => _VerficationScreenState();
}

class _VerficationScreenState extends State<VerficationScreen> {
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
          style: TextTheme.of(context).titleLarge!.copyWith(fontSize: 16),
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
                      color: Apptheme.darkGray,
                      borderRadius: BorderRadius.circular(122),
                    ),
                    child: Center(
                      child: Container(
                        height: 92,
                        width: 92,
                        decoration: BoxDecoration(
                          color: Apptheme.primaryColor,
                          borderRadius: BorderRadius.circular(92),
                        ),
                        child: Icon(
                          Icons.lock,
                          color: Apptheme.white,
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
                    style: TextTheme.of(context).titleSmall,
                  ),
                  Text(
                    email, // Should always be valid
                    style: TextTheme.of(
                      context,
                    ).titleLarge!.copyWith(fontSize: 16),
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
                  DefaultElevetedBotton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        focusNode.unfocus();
                        Navigator.of(
                          context,
                        ).pushReplacementNamed(UserProfileForm.routeName);
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
