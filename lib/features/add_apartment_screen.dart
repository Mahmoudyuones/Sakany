import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakany/core/resources/color_manager.dart';
import 'package:sakany/core/resources/font_manager.dart';
import 'package:sakany/core/resources/style_manager.dart';
import 'package:sakany/core/widgets/clickabe_upload.dart';
import 'package:sakany/core/widgets/default_elevated_button.dart';
import 'dart:io';

import 'package:sakany/core/widgets/default_text_form_field.dart';
import 'package:sakany/features/auth/data/data_source/image_picker_functions.dart';
import 'package:sakany/features/auth/data/data_source/local/remote/clodarinay_service.dart';
import 'package:sakany/features/home/apartment_service.dart';

class AddApartmentScreen extends StatefulWidget {
  static const routeName = '/add_apartment';
  const AddApartmentScreen({super.key});

  @override
  State<AddApartmentScreen> createState() => _AddApartmentScreenState();
}

class _AddApartmentScreenState extends State<AddApartmentScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _roomsController = TextEditingController();
  final TextEditingController _bedsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? location;
  File? apartmentImageFile;
  bool _hasWifi = false;
  // File? _imageFile;
  String? mainImageurl;
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      mainImageurl =
          apartmentImageFile != null
              ? await CloudinaryService.uploadImage(apartmentImageFile!)
              : '';

      final isSuccess = await ApartmentService.addApartment(
        title: _titleController.text.trim(),
        rooms: int.parse(_roomsController.text),
        beds: int.parse(_bedsController.text),
        isWifi: _hasWifi,
        description: _descriptionController.text.trim(),
        location: location ?? '',
        imageFile: mainImageurl,
        ownerId: "d0a2d9ff-4dbf-4038-8474-08dda26946bd",
      );

      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Apartment submitted successfully!")),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to submit apartment.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Apartment"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DefaultTextFormField(
                hintText: "Enter apartment Title",
                label: "Apartment Title",
                isPassword: false,
                controller: _titleController,
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),

              SizedBox(height: 10.h),
              DefaultTextFormField(
                hintText: "Enter the number of Rooms",
                label: "Number of Rooms",
                isPassword: false,
                controller: _roomsController,
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),

              SizedBox(height: 10.h),
              DefaultTextFormField(
                hintText: "Enter the number of Beds",
                label: "Number of Beds",
                isPassword: false,
                controller: _bedsController,
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),

              SizedBox(height: 10.h),
              SwitchListTile(
                title: Text(
                  "Wi-Fi Available",
                  style: getBoldStyle(
                    color: ColorManager.primaryColor,
                    fontSize: FontSize.s17,
                  ),
                ),
                value: _hasWifi,
                onChanged: (value) => setState(() => _hasWifi = value),
              ),
              DefaultTextFormField(
                hintText: "Enter the description of the apartment",
                label: "Description",
                isPassword: false,
                controller: _descriptionController,
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),

              SizedBox(height: 10.h),
              const Text("Select Location"),
              DropdownButton<String>(
                isExpanded: true,
                value: location, // now nullable
                hint: const Text('Choose a location'),
                items:
                    ['seed', 'maktbat', 'city', 'yousrey', 'zahraa']
                        .map(
                          (feature) => DropdownMenuItem(
                            value: feature,
                            child: Text(feature),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() => location = value);
                },
              ),
              SizedBox(height: 10.h),
              apartmentImageFile != null
                  ? Image.file(
                    apartmentImageFile!,
                    height: 150.h,
                    fit: BoxFit.cover,
                  )
                  : ClickableIdUpload(
                    title: 'Apartment Image',
                    description: "select the apartment Image",
                    onTap: () async {
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
                                        apartmentImageFile = temp;
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
                                        apartmentImageFile = temp;
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
                  ),
              SizedBox(height: 20.h),
              DefaultElevatedButton(onPressed: _submitForm, text: "Submit"),
            ],
          ),
        ),
      ),
    );
  }
}
