import 'package:flutter/material.dart';

class ApartmentCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final int numberOfRooms;
  final int totalBeds;
  final List<String> features;
  final double price;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onDetailsPressed;

  const ApartmentCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.numberOfRooms,
    required this.totalBeds,
    required this.features,
    required this.price,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onDetailsPressed,
  });

  Icon _featureIcon(String feature) {
    switch (feature.toLowerCase()) {
      case 'wifi':
        return const Icon(Icons.wifi, size: 18);
      case 'elevator':
        return const Icon(Icons.elevator, size: 18);
      case 'ac':
      case 'air conditioning':
        return const Icon(Icons.ac_unit, size: 18);
      case 'balcony':
        return const Icon(Icons.balcony, size: 18);
      case 'washing machine':
        return const Icon(Icons.local_laundry_service, size: 18);
      default:
        return const Icon(Icons.check_circle_outline, size: 18);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title & Location
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(location, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),

                // Rooms and Beds Info
                Row(
                  children: [
                    Icon(Icons.meeting_room, size: 18, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text('$numberOfRooms rooms'),

                    const SizedBox(width: 16),
                    Icon(Icons.bed, size: 18, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text('$totalBeds beds'),

                    const SizedBox(width: 16),
                  ],
                ),
                const SizedBox(height: 8),

                // Features
                Wrap(
                  spacing: 10,
                  children:
                      features
                          .map(
                            (feature) => Chip(
                              avatar: _featureIcon(feature),
                              label: Text(feature),
                              visualDensity: VisualDensity.compact,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 0,
                              ),
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: 12),

                // Price and Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$price EGP / month',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: onDetailsPressed,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('View Details'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
