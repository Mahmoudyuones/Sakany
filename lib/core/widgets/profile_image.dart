import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakany/core/resources/color_manager.dart';
import 'package:sakany/features/auth/data/data_source/image_picker_functions.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 70.r,
                  backgroundColor: ColorManager.gray,
                  backgroundImage:
                      imageFile != null ? FileImage(imageFile!) : null,
                  child:
                      imageFile == null
                          ? Icon(Icons.person, size: 80.sp, color: Colors.white)
                          : null,
                ),
                Positioned(
                  bottom: 8.h,
                  right: 8.w,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              contentPadding: const EdgeInsets.all(16),
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      var temp =
                                          await ImagePickerFunctions.gallery();
                                      if (temp != null) {
                                        imageFile = temp;
                                      }
                                      setState(() {});
                                      Navigator.of(context).pop();
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.image,
                                          size: 30.sp,
                                          color: ColorManager.primaryColor,
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
                                        imageFile = temp;
                                      }
                                      setState(() {});
                                      Navigator.of(context).pop();
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.camera_alt,
                                          size: 30.sp,
                                          color: ColorManager.primaryColor,
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
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 20.sp,
                        color: ColorManager.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          'Upload profile picture',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
