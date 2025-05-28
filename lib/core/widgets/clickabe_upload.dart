import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakany/core/resources/color_manager.dart';
import 'package:sakany/core/resources/font_manager.dart';
import 'package:sakany/core/resources/style_manager.dart' as StylesManager;

class ClickableIdUpload extends StatelessWidget {
  final String title;
  final String description;
  final void Function() onTap;
  final File? imageFile;

  const ClickableIdUpload({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: DottedBorder(
          color: ColorManager.appBarTitle,
          strokeWidth: 1,
          dashPattern: const [6, 4],
          borderType: BorderType.RRect,
          radius: Radius.circular(12.r),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.white,
            ),
            child:
                imageFile != null
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.file(
                        imageFile!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 150.h,
                      ),
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                textAlign: TextAlign.right,
                                style: StylesManager.getBoldStyle(
                                  color: ColorManager.appBarTitle,
                                  fontSize: FontSize.s14,
                                ),
                              ),
                              Text(
                                description,
                                textAlign: TextAlign.right,
                                style: StylesManager.getBoldStyle(
                                  color: ColorManager.appBarTitle,
                                  fontSize: FontSize.s12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Icon(
                            Icons.add,
                            color: ColorManager.appBarTitle,
                          ),
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
