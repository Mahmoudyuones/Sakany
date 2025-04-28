import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sakany/auth/view/widgets/profile_image.dart';
import 'package:sakany/auth/view/widgets/custom_dropdown_botton.dart';
import 'package:sakany/shared/app_validator.dart';
import 'package:sakany/shared/apptheme.dart';
import 'package:sakany/home/home_screen.dart';
import 'package:sakany/shared/widgets/default_eleveted_botton.dart';
import 'package:sakany/shared/widgets/default_text_form_fieled.dart';

class UserProfileFormScreen extends StatefulWidget {
  static const String routeName = '/User_profile_form';
  const UserProfileFormScreen({super.key});

  @override
  State<UserProfileFormScreen> createState() => _UserProfileFormScreenState();
}

class _UserProfileFormScreenState extends State<UserProfileFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Complete Your Profile",
          style: TextTheme.of(context).titleLarge!.copyWith(fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProfileImage(),
                Row(
                  children: [
                    Expanded(
                      child: DefaultTextFormFieled(
                        hintText: 'First Name',
                        label: 'First Name',
                        icon: null,
                        isPassword: false,
                        controller: _firstNameController,
                        validator: (value) {
                          if (value == null || value.trim() == '') {
                            return 'Please Enter Your First Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DefaultTextFormFieled(
                        hintText: 'Last Name',
                        label: 'last Name',
                        icon: null,
                        isPassword: false,
                        controller: _lastNameController,
                        validator: (value) {
                          if (value == null || value.trim() == '') {
                            return 'Please Enter Your last Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),
                DefaultTextFormFieled(
                  hintText: 'Phone Number',
                  label: 'Phone Number',
                  icon: null,
                  isPassword: false,
                  controller: _phoneController,
                  validator: (value) {
                    if (value == null || value.trim() == '') {
                      return 'Please Enter Your Phone Number';
                    } else if (!AppValidator.isPhoneValid(value)) {
                      return 'Please Enter a valid Phone Number';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),
                DefaultTextFormFieled(
                  hintText: 'Region',
                  label: 'Region',
                  icon: null,
                  isPassword: false,
                  controller: _regionController,
                  validator: (value) {
                    if (value == null || value.trim() == '') {
                      return 'Please Enter Your Region';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),
                DefaultTextFormFieled(
                  hintText: 'Adress',
                  label: 'Adress',
                  icon: null,
                  isPassword: false,
                  controller: _adressController,
                  validator: (value) {
                    if (value == null || value.trim() == '') {
                      return 'Please Enter Your Adress';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),
                DefaultTextFormFieled(
                  hintText: 'University',
                  label: 'University',
                  icon: null,
                  isPassword: false,
                  controller: _universityController,
                  validator: (value) {
                    if (value == null || value.trim() == '') {
                      return 'Please Enter Your University';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),
                DefaultTextFormFieled(
                  hintText: 'College',
                  label: 'College',
                  icon: null,
                  isPassword: false,
                  controller: _collegeController,
                  validator: (value) {
                    if (value == null || value.trim() == '') {
                      return 'Please Enter Your College';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                CustomDropdownBotton(
                  hintText: 'Select Year',
                  isExpaned: true,
                  list: [
                    '1st Year',
                    '2nd Year',
                    '3rd Year',
                    '4th Year',
                    '5th Year',
                    '6th Year',
                    '7th Year',
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomDropdownBotton(
                      hintText: 'Select Gender',
                      list: ['Male', 'Female'],
                    ),
                    Expanded(
                      child: InkWell(
                        child: Center(
                          child: Text(
                            " Birth Date\n${dateFormat.format(selectedDate)}",
                            style: TextTheme.of(
                              context,
                            ).titleMedium!.copyWith(color: Apptheme.black),
                          ),
                        ),
                        onTap: () async {
                          DateTime? dateTime = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2005),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                          );
                          if (dateTime != null && dateTime != selectedDate) {
                            selectedDate = dateTime;
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),
                DefaultElevetedBotton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(HomeScreen.routeName);
                    }
                  },
                  text: ('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
