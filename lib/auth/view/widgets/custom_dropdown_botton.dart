import 'package:flutter/material.dart';
import 'package:sakany/shared/apptheme.dart';

class CustomDropdownBotton extends StatefulWidget {
  const CustomDropdownBotton({
    super.key,
    required this.list,
    this.isExpaned = false,
    required this.hintText,
  });
  final List<String> list;
  final bool isExpaned;
  final String hintText;
  @override
  State<CustomDropdownBotton> createState() => _CustomDropdownBottonState();
}

class _CustomDropdownBottonState extends State<CustomDropdownBotton> {
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
          isExpanded: widget.isExpaned,
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
                      color: Apptheme.textColor,
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
