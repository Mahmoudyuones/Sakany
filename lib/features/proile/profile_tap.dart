import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sakany/core/resources/color_manager.dart';
import 'package:sakany/core/utils/ui_utils.dart';
import 'package:sakany/core/widgets/clickabe_upload.dart';
import 'package:sakany/core/widgets/custom_dropdown_button.dart';
import 'package:sakany/core/widgets/default_elevated_button.dart';
import 'package:sakany/core/widgets/default_text_form_field.dart';
import 'package:sakany/core/widgets/phone_input_field.dart';

import 'package:sakany/core/widgets/profile_image.dart';
import 'package:sakany/features/auth/data/data_source/image_picker_functions.dart';
import 'package:sakany/features/auth/data/data_source/local/remote/clodarinay_service.dart';
import 'package:sakany/features/proile/owner_model.dart';
import 'package:sakany/features/proile/owner_service.dart';
import 'package:sakany/features/proile/student_model.dart';
import 'package:sakany/features/proile/student_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileData {
  final bool isOwner;
  final StudentModel? studentData;
  final OwnerModel? ownerData;

  ProfileData({required this.isOwner, this.studentData, this.ownerData});
}

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late Future<ProfileData> _profileFuture;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  bool? isOwner;
  File? frontImageFile;
  File? backImageFile;
  String? profileImageURL;
  String? frontIDImageURL;
  String? backIDImageURL;
  String? selectedGender;
  String? selectedReligion;

  bool _isInitialDataSet = false;

  @override
  void initState() {
    super.initState();
    _profileFuture = _getProfileFuture();
  }

  Future<ProfileData> _getProfileFuture() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    if (userId == null) {
      throw Exception('User ID not found');
    }
    final userRole = prefs.getInt('userRole');
    final isOwnerLocal = userRole == 1;
    if (isOwnerLocal) {
      final ownerData = await OwnerService.fetchOwnerData(userId);
      return ProfileData(isOwner: true, ownerData: ownerData);
    } else {
      final studentData = await StudentService.fetchStudentData(userId);
      return ProfileData(isOwner: false, studentData: studentData);
    }
  }

  Future<void> _editProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    if (userId == null) {
      throw Exception('User ID not found');
    }
    try {
      if (!isOwner!) {
        await StudentService.editStudentData(
          studentId: userId,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          collegeName: _collegeController.text,
          age: int.tryParse(_ageController.text) ?? 0,
          origin: _addressController.text,
          religon: selectedReligion ?? '',
          profilePhoto: profileImageURL ?? '',
          phoneNumber: _phoneController.text,
          gender: selectedGender ?? '',
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      } else {
        frontIDImageURL =
            frontImageFile != null
                ? await CloudinaryService.uploadImage(frontImageFile!)
                : '';
        backIDImageURL =
            backImageFile != null
                ? await CloudinaryService.uploadImage(backImageFile!)
                : "";
        await OwnerService.editOwnerData(
          ownerId: userId,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          residence: _addressController.text,
          religion: selectedReligion ?? '',
          profilePhoto: profileImageURL ?? '',
          phoneNumber: _phoneController.text,
          frontId: frontIDImageURL ?? '',
          backId: backIDImageURL ?? '',
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error updating profile: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProfileData>(
      future: _profileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: ColorManager.primaryColor),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final profileData = snapshot.data!;
          if (!_isInitialDataSet) {
            isOwner = profileData.isOwner;
            if (!isOwner!) {
              final student = profileData.studentData!;
              _firstNameController.text = student.firstName;
              _lastNameController.text = student.lastName;
              _phoneController.text = student.phoneNumber ?? '';
              _addressController.text = student.origin ?? '';
              _collegeController.text = student.collegeName ?? '';
              _ageController.text = student.age?.toString() ?? '';
              profileImageURL = student.profilePhoto;
              selectedGender = student.gender;
              selectedReligion =
                  student.religon == 'Muslim'
                      ? 'Muslim'
                      : student.religon == 'Christian'
                      ? 'Christian'
                      : null;
            } else {
              final owner = profileData.ownerData!;
              _firstNameController.text = owner.firstName;
              _lastNameController.text = owner.lastName;
              _phoneController.text = owner.phoneNumber ?? '';
              _addressController.text = owner.residence ?? '';
              profileImageURL = owner.profilePhoto;
              selectedGender = owner.gender;
              selectedReligion =
                  owner.religion == 'muslim'
                      ? 'Muslim'
                      : owner.religion == 'christian'
                      ? 'Christian'
                      : null;
            }
            _isInitialDataSet = true;
          }

          return Padding(
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
                                initialImageUrl: profileImageURL,
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
                              PhoneInputField(controller: _phoneController),
                              if (!isOwner!) ...[
                                SizedBox(height: 15.h),
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
                                SizedBox(height: 20.h),
                                DefaultTextFormField(
                                  hintText: "Enter your age",
                                  label: "Age",
                                  isPassword: false,
                                  controller: _ageController,
                                ),
                              ],
                              if (isOwner!) ...[
                                SizedBox(height: 20.h),
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
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      var temp =
                                                          await ImagePickerFunctions.gallery();
                                                      if (temp != null) {
                                                        frontImageFile = temp;
                                                      }
                                                      setState(() {});
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
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
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
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
                                        'Please upload the front of your ID',
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
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      var temp =
                                                          await ImagePickerFunctions.gallery();
                                                      if (temp != null) {
                                                        backImageFile = temp;
                                                      }
                                                      setState(() {});
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
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
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
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
                                        'Please upload the back of your ID',
                                    title: 'Tap to add an image',
                                    imageFile: backImageFile,
                                  ),
                                ),
                              ],
                              Expanded(child: SizedBox()),
                              SizedBox(height: 20.h),
                              DefaultElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    UIUtils.showLoading(context);
                                    await _editProfile();
                                    UIUtils.hideLoading(context);
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
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _collegeController.dispose();
    _ageController.dispose();
    super.dispose();
  }
}
