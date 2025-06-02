import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sakany/core/resources/color_manager.dart';
import 'package:sakany/core/widgets/default_elevated_button.dart';
import 'package:sakany/core/widgets/loading_indecator.dart';

class UIUtils {
  static void showFilterDialog(
    BuildContext context, {
    required void Function(String? selectedLocation, double maxPrice) onApply,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        String? selectedFeature;
        RangeValues priceRange = const RangeValues(1000, 10000);

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text('Filter Apartments'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Select Location"),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: selectedFeature,
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
                      setState(() => selectedFeature = value);
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text("Select Price Range"),
                  RangeSlider(
                    values: priceRange,
                    min: 0,
                    max: 20000,
                    divisions: 100,
                    labels: RangeLabels(
                      '${priceRange.start.toInt()} EGP',
                      '${priceRange.end.toInt()} EGP',
                    ),
                    activeColor: ColorManager.primaryColor,
                    inactiveColor: ColorManager.primaryColor.withOpacity(0.3),
                    onChanged: (values) {
                      setState(() => priceRange = values);
                    },
                  ),
                ],
              ),
              actions: [
                DefaultElevatedButton(
                  onPressed: () {
                    onApply(selectedFeature, priceRange.end);
                    Navigator.of(context).pop();
                  },
                  text: "Apply",
                ),
              ],
            );
          },
        );
      },
    );
  }

  static void showLoading(BuildContext context) => showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (_) => PopScope(
          canPop: false,
          child: AlertDialog(
            content: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.2,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [LoadingIndicator()],
              ),
            ),
          ),
        ),
  );

  static void hideLoading(BuildContext context) => Navigator.of(context).pop();

  static void showMessage(String message) =>
      Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT);
}
