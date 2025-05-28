import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakany/core/resources/color_manager.dart';
import 'package:sakany/core/widgets/default_elevated_button.dart';

class ServicesTap extends StatelessWidget {
  const ServicesTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Apartment Examination Service',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: ColorManager.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 12.h),

          // Description
          Text(
            'We provide a professional apartment inspection service to ensure safety, cleanliness, and compliance before you rent.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp, height: 1.6),
          ),
          SizedBox(height: 20.h),

          // Illustration or icon
          Center(
            child: Icon(
              Icons.library_add_check_rounded, // Or any inspection-related icon
              size: 120.sp,
              color: ColorManager.primaryColor.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 30.h),

          // Call-to-action button
          DefaultElevatedButton(
            text: 'Request Apartment Inspection',
            onPressed: () {
              // Navigate or show form
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Request submitted. We will contact you soon!'),
                ),
              );
            },
          ),

          // Optional: Spacer and info
          const Spacer(),

          Text(
            'Note: This service is currently available in selected areas only.',
            style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
