import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sakany/auth/data/data_source/image_picker_functions.dart';
import 'package:sakany/shared/apptheme.dart';

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
                  radius: 70,
                  backgroundColor: AppTheme.gray,
                  backgroundImage:
                      imageFile != null ? FileImage(imageFile!) : null,
                  child:
                      imageFile == null
                          ? Icon(Icons.person, size: 80, color: Colors.white)
                          : null,
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
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
                                          size: 30,
                                          color: AppTheme.primaryColor,
                                        ),
                                        const SizedBox(height: 8),
                                        const Text('Gallery'),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 24),
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
                                          size: 30,
                                          color: AppTheme.primaryColor,
                                        ),
                                        const SizedBox(height: 8),
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
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 20,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Upload profile picture',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
