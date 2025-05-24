import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakany/core/resources/color_manager.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({
    super.key,
    required this.list,
    this.isExpanded = false,
    required this.hintText,
    this.value,
    this.onChanged,
    this.validator,
  });

  final List<String> list;
  final bool isExpanded;
  final String hintText;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final String? Function(String?)? validator;

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? selectedItem;
  String? errorText;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.value;
  }

  @override
  void didUpdateWidget(CustomDropdownButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      selectedItem = widget.value;
    }
  }

  void _validateField() {
    if (widget.validator != null) {
      setState(() {
        errorText = widget.validator!(selectedItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: errorText != null ? Colors.red : Colors.grey.shade400,
            ),
            color: Colors.white,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(12.r),
              dropdownColor: Colors.grey.shade200,
              isExpanded: widget.isExpanded,
              hint: Text(widget.hintText),
              value: selectedItem,
              icon: const Icon(Icons.keyboard_arrow_down),
              items:
                  widget.list.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: ColorManager.textColor),
                      ),
                    );
                  }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedItem = newValue;
                  errorText = null; // Clear error when user selects something
                });

                // Call the external onChanged callback if provided
                if (widget.onChanged != null) {
                  widget.onChanged!(newValue);
                }

                // Validate the field
                _validateField();
              },
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 4.h),
            child: Text(
              errorText!,
              style: TextStyle(color: Colors.red, fontSize: 12.sp),
            ),
          ),
      ],
    );
  }
}
