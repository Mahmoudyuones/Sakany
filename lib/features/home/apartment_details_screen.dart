import 'package:flutter/material.dart';
import 'package:sakany/core/resources/color_manager.dart';
import 'package:sakany/core/resources/font_manager.dart';
import 'package:sakany/core/resources/style_manager.dart';
import 'package:sakany/features/home/models/apartment_model.dart';

class ApartmentDetailsScreen extends StatelessWidget {
  final ApartmentModel apartment;

  const ApartmentDetailsScreen({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    final totalPrice = apartment.rooms
        .expand((r) => r.beds)
        .map((b) => b.price)
        .fold<double>(0, (sum, price) => sum + price);

    final totalBeds = apartment.rooms.fold<int>(
      0,
      (sum, room) => sum + room.beds.length,
    );

    return Scaffold(
      appBar: AppBar(
        foregroundColor: ColorManager.white,
        centerTitle: true,
        title: Text(
          apartment.apartmentTitle,
          style: getBoldStyle(color: Colors.white, fontSize: FontSize.s18),
        ),
        backgroundColor: ColorManager.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                apartment.mainImage,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Location & Price
            Text(
              apartment.location,
              style: getMediumStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSize.s16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "$totalPrice EGP / month",
              style: getBoldStyle(
                fontSize: FontSize.s18,
                color: ColorManager.primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            const Divider(),

            // Description
            Text(
              "Description",
              style: getBoldStyle(
                fontSize: FontSize.s16,
                color: ColorManager.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              apartment.description.isNotEmpty
                  ? apartment.description
                  : "No description provided.",
              style: getRegularStyle(
                fontSize: FontSize.s14,
                color: ColorManager.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),

            // Room & Bed Info
            Row(
              children: [
                Expanded(
                  child: _infoCard("Rooms", apartment.rooms.length.toString()),
                ),
                const SizedBox(width: 12),
                Expanded(child: _infoCard("Beds", totalBeds.toString())),
              ],
            ),
            const SizedBox(height: 16),

            // Features
            if (apartment.isWifi)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Features",
                    style: getBoldStyle(
                      fontSize: FontSize.s16,
                      color: ColorManager.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (apartment.isWifi) _featureChip("Wi-Fi"),

                      // Add more if needed
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 24),
            Text(
              "Room Details",
              style: getBoldStyle(
                fontSize: FontSize.s16,
                color: ColorManager.primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(apartment.rooms.length, (roomIndex) {
                final room = apartment.rooms[roomIndex];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Room ${roomIndex + 1}",
                      style: getMediumStyle(
                        fontSize: FontSize.s16,
                        color: ColorManager.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ...List.generate(room.beds.length, (bedIndex) {
                      final bed = room.beds[bedIndex];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          "• Bed ${bedIndex + 1} - ${bed.price} EGP",
                          style: getRegularStyle(
                            fontSize: FontSize.s14,
                            color: ColorManager.primaryColor,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 12),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            Text(
              value,
              style: getBoldStyle(
                fontSize: FontSize.s18,
                color: ColorManager.primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: getRegularStyle(
                fontSize: FontSize.s14,
                color: ColorManager.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: ColorManager.primaryColor.withOpacity(0.1),
      labelStyle: getMediumStyle(color: ColorManager.primaryColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
