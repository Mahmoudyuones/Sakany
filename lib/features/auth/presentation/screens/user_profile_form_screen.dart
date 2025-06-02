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
import 'package:sakany/features/auth/data/data_source/local/remote/clodarinay_service.dart';

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

  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  DateTime selectedDate = DateTime.now();

  bool isOwner = true;
  File? profileImage;
  String? profileImageURL;

  File? frontImageFile;
  String? frontImageFileURL;
  File? backImageFile;
  String? backImageFileURL;

  String? selectedGender;
  String? selectedReligion;
  String? selectedYear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeInDown(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            ProfileImage(
                              onImageUploaded: (url) {
                                setState(() {
                                  profileImageURL = url;
                                });
                              },
                            ),
                            SizedBox(height: 30.h),

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
                                      if (value == null ||
                                          value.trim().isEmpty) {
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
                                      if (value == null ||
                                          value.trim().isEmpty) {
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

                            if (isOwner) SizedBox(height: 15.h),

                            // Gender and Religion Row
                            if (!isOwner)
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
                                  SizedBox(width: 30.w),
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
                            if (!isOwner) SizedBox(height: 20.h),
                            // Birth Date Selector
                            if (!isOwner)
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
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Birth Date: ${dateFormat.format(selectedDate)}",
                                        style: TextTheme.of(
                                          context,
                                        ).titleMedium!.copyWith(
                                          color: ColorManager.black,
                                        ),
                                      ),
                                      Icon(
                                        Icons.calendar_today,
                                        color: Colors.grey.shade600,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if (isOwner) SizedBox(height: 20.h),
                            if (isOwner) ...[
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  'To manage to Post apartments upload your ID',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
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
                                            contentPadding:
                                                const EdgeInsets.all(16),
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
                                                      final imageUrl =
                                                          await CloudinaryService.uploadImage(
                                                            frontImageFile!,
                                                          );

                                                      if (imageUrl != null) {
                                                        frontImageFileURL =
                                                            imageUrl;
                                                      } else {
                                                        print(
                                                          '❌ Failed to upload image',
                                                        );
                                                      }
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
                                                      final imageUrl =
                                                          await CloudinaryService.uploadImage(
                                                            frontImageFile!,
                                                          );

                                                      if (imageUrl != null) {
                                                        frontImageFileURL =
                                                            imageUrl;
                                                      } else {
                                                        print(
                                                          '❌ Failed to upload image',
                                                        );
                                                      }
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
                                  description:
                                      'Pleas upload the front of you ID',
                                  title: 'Tap to add an image',
                                  imageFile: frontImageFile,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              FadeInDown(
                                child: ClickableIdUpload(
                                  onTap: () async {
                                    showDialog(
                                      context: context,
                                      builder:
                                          (context) => AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.all(16),
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
                                                      final imageUrl =
                                                          await CloudinaryService.uploadImage(
                                                            frontImageFile!,
                                                          );

                                                      if (imageUrl != null) {
                                                        backImageFileURL =
                                                            imageUrl;
                                                      } else {
                                                        print(
                                                          '❌ Failed to upload image',
                                                        );
                                                      }
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
                                                      final imageUrl =
                                                          await CloudinaryService.uploadImage(
                                                            frontImageFile!,
                                                          );

                                                      if (imageUrl != null) {
                                                        backImageFileURL =
                                                            imageUrl;
                                                      } else {
                                                        print(
                                                          '❌ Failed to upload image',
                                                        );
                                                      }
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
                                  description:
                                      'Pleas upload the back of you ID',
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
                                print(profileImageURL);
                                print(frontImageFileURL);
                                print(backImageFileURL);
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
      ),
    );
  }
}
