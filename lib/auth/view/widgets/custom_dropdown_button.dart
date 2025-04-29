import 'package:flutter/material.dart';
import 'package:sakany/shared/apptheme.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({
    super.key,
    required this.list,
    this.isExpanded = false,
    required this.hintText,
  });
  final List<String> list;
  final bool isExpanded;
  final String hintText;
  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(12),
          dropdownColor: Colors.grey.shade200,
          isExpanded: widget.isExpanded,
          hint: Text(widget.hintText),
          value: selectedItem,
          icon: const Icon(Icons.keyboard_arrow_down),
          items:
              widget.list.map((String year) {
                return DropdownMenuItem<String>(
                  value: year,
                  child: Text(
                    year,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppTheme.textColor,
                    ),
                  ),
                );
              }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedItem = newValue;
            });
          },
        ),
      ),
    );
  }
}
