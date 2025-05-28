import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sakany/core/resources/color_manager.dart';
import 'package:sakany/core/widgets/clickabe_upload.dart';
import 'package:sakany/core/widgets/phone_input_field.dart';
import 'package:sakany/core/widgets/profile_image.dart';
import 'package:sakany/core/widgets/custom_dropdown_button.dart';
import 'package:sakany/core/widgets/default_elevated_button.dart';
import 'package:sakany/core/widgets/default_text_form_field.dart';
import 'package:sakany/features/auth/data/data_source/image_picker_functions.dart';
import 'package:sakany/home_screen.dart';

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
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();

  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  DateTime selectedDate = DateTime.now();
  bool isLoggedIn = true;
  bool isOwner = false;
  File? frontImageFile;
  File? backImageFile;

  // Variables to track selected values
  String? selectedGender;
  String? selectedReligion;
  String? selectedYear;
  String? selectedUserType; // Student or Owner

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          ProfileImage(),
                          SizedBox(height: 30.h),

                          // First Name and Last Name Row
                          Row(
                            children: [
                              Expanded(
                                child: DefaultTextFormField(
                                  hintText: 'First Name',
                                  label: 'First Name',
                                  icon: null,
                                  isPassword: false,
                                  controller: _firstNameController,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please Enter Your First Name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: DefaultTextFormField(
                                  hintText: 'Last Name',
                                  label: 'Last Name',
                                  icon: null,
                                  isPassword: false,
                                  controller: _lastNameController,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please Enter Your Last Name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20.h),

                          // Phone Number
                          PhoneInputField(controller: _phoneController),

                          // User Type Selection (only show when not logged in)
                          if (!isLoggedIn) ...[
                            SizedBox(height: 15.h),
                            SizedBox(
                              width: double.infinity,
                              child: CustomDropdownButton(
                                hintText: 'I am a',
                                list: ['Student', 'Owner'],
                                value: selectedUserType,
                                onChanged: (value) {
                                  setState(() {
                                    selectedUserType = value;
                                    if (selectedUserType == "Owner") {
                                      isOwner = true;
                                    }
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select if you are a student or owner';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],

                          // Conditional fields for logged in users
                          if (isLoggedIn) ...[
                            SizedBox(height: 15.h),

                            // Address
                            DefaultTextFormField(
                              hintText: 'Address',
                              label: 'Address',
                              icon: null,
                              isPassword: false,
                              controller: _addressController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please Enter Your Address';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 15.h),

                            // University
                            DefaultTextFormField(
                              hintText: 'University',
                              label: 'University',
                              icon: null,
                              isPassword: false,
                              controller: _universityController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please Enter Your University';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 15.h),

                            // College
                            DefaultTextFormField(
                              hintText: 'College',
                              label: 'College',
                              icon: null,
                              isPassword: false,
                              controller: _collegeController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please Enter Your College';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 15.h),

                            // Academic Year
                            CustomDropdownButton(
                              hintText: 'Select Year',
                              isExpanded: true,
                              list: [
                                '1st Year',
                                '2nd Year',
                                '3rd Year',
                                '4th Year',
                                '5th Year',
                                '6th Year',
                                '7th Year',
                              ],
                              value: selectedYear,
                              onChanged: (value) {
                                setState(() {
                                  selectedYear = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your academic year';
                                }
                                return null;
                              },
                            ),
                          ],

                          SizedBox(height: 15.h),

                          // Gender and Religion Row
                          Row(
                            children: [
                              Expanded(
                                child: CustomDropdownButton(
                                  hintText: 'Select Gender',
                                  list: ['Male', 'Female'],
                                  value: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select your gender';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: CustomDropdownButton(
                                  hintText: 'Select Religion',
                                  list: ['Muslim', 'Christian'],
                                  value: selectedReligion,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedReligion = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select your religion';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 25.h),

                          // Birth Date Selector
                          InkWell(
                            onTap: () async {
                              DateTime? dateTime = await showDatePicker(
                                context: context,
                                initialDate: DateTime(2005),
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now(),
                              );
                              if (dateTime != null &&
                                  dateTime != selectedDate) {
                                setState(() {
                                  selectedDate = dateTime;
                                });
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 16.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: Colors.grey.shade400),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Birth Date: ${dateFormat.format(selectedDate)}",
                                    style: TextTheme.of(context).titleMedium!
                                        .copyWith(color: ColorManager.black),
                                  ),
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.grey.shade600,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (selectedUserType == 'Owner' || isOwner) ...[
                            SizedBox(height: 10.h),
                            FadeInDown(
                              child: ClickableIdUpload(
                                onTap: () async {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => AlertDialog(
                                          contentPadding: const EdgeInsets.all(
                                            16,
                                          ),
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  var temp =
                                                      await ImagePickerFunctions.gallery();
                                                  if (temp != null) {
                                                    frontImageFile = temp;
                                                  }
                                                  setState(() {});
                                                  Navigator.of(context).pop();
                                                },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.image,
                                                      size: 30.sp,
                                                      color:
                                                          ColorManager
                                                              .primaryColor,
                                                    ),
                                                    SizedBox(height: 8.h),
                                                    const Text('Gallery'),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 24.w),
                                              GestureDetector(
                                                onTap: () async {
                                                  var temp =
                                                      await ImagePickerFunctions.camera();
                                                  if (temp != null) {
                                                    frontImageFile = temp;
                                                  }
                                                  setState(() {});
                                                  Navigator.of(context).pop();
                                                },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt,
                                                      size: 30.sp,
                                                      color:
                                                          ColorManager
                                                              .primaryColor,
                                                    ),
                                                    SizedBox(height: 8.h),
                                                    const Text('Camera'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  );
                                },
                                description: 'Pleas upload the front of you ID',
                                title: 'Tap to add an image',
                                imageFile: frontImageFile,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            FadeInDown(
                              child: ClickableIdUpload(
                                onTap: () async {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => AlertDialog(
                                          contentPadding: const EdgeInsets.all(
                                            16,
                                          ),
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  var temp =
                                                      await ImagePickerFunctions.gallery();
                                                  if (temp != null) {
                                                    backImageFile = temp;
                                                  }
                                                  setState(() {});
                                                  Navigator.of(context).pop();
                                                },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.image,
                                                      size: 30.sp,
                                                      color:
                                                          ColorManager
                                                              .primaryColor,
                                                    ),
                                                    SizedBox(height: 8.h),
                                                    const Text('Gallery'),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 24.w),
                                              GestureDetector(
                                                onTap: () async {
                                                  var temp =
                                                      await ImagePickerFunctions.camera();
                                                  if (temp != null) {
                                                    backImageFile = temp;
                                                  }
                                                  setState(() {});
                                                  Navigator.of(context).pop();
                                                },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt,
                                                      size: 30.sp,
                                                      color:
                                                          ColorManager
                                                              .primaryColor,
                                                    ),
                                                    SizedBox(height: 8.h),
                                                    const Text('Camera'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  );
                                },
                                description: 'Pleas upload the back of you ID',
                                title: 'Tap to add an image',
                                imageFile: backImageFile,
                              ),
                            ),
                          ],

                          // Spacer to push submit button to bottom
                          Expanded(child: SizedBox()),
                          SizedBox(height: 20.h),

                          // Submit Button
                          DefaultElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.of(
                                  context,
                                ).pushReplacementNamed(HomeScreen.routeName);
                              }
                            },
                            text: 'Submit',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
