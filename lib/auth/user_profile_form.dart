import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sakany/apptheme.dart';
import 'package:sakany/home/home_screen.dart';
import 'package:sakany/widgets/default_eleveted_botton.dart';
import 'package:sakany/widgets/default_text_form_fieled.dart';

class UserProfileForm extends StatefulWidget {
  static const String routeName = '/User_profile_form';
  const UserProfileForm({super.key});

  @override
  State<UserProfileForm> createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  String? _selectedGender = 'Male';
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

                const SizedBox(height: 15),
                DefaultTextFormFieled(
                  hintText: 'Phone Number',
                  label: 'Phone Number',
                  icon: null,
                  isPassword: false,
                  controller: _phoneController,
                  validator: (value) {
                    if (value == null || value.trim() == '') {
                      return 'Please Enter Your Number Name';
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

                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedGender,
                        dropdownColor: Apptheme.darkGray,
                        borderRadius: BorderRadius.circular(15),
                        style: TextTheme.of(
                          context,
                        ).titleMedium!.copyWith(color: Apptheme.black),
                        items: [
                          DropdownMenuItem<String>(
                            value: 'Male',
                            child: Text('Male'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Female',
                            child: Text('Female'),
                          ),
                        ],
                        onChanged: (selectedGender) {
                          if (selectedGender != null) {
                            _selectedGender = selectedGender;
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    InkWell(
                      child: Text(
                        " Birth Date\n${dateFormat.format(selectedDate)}",
                        style: TextTheme.of(
                          context,
                        ).titleMedium!.copyWith(color: Apptheme.black),
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
