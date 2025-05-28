import 'package:flutter/material.dart';
import 'package:sakany/core/widgets/appartment_card.dart';

class FavoritesTap extends StatelessWidget {
  const FavoritesTap({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> favoriteApartments = [
      {
        'imageUrl':
            'https://imgs.search.brave.com/FckAPpfU1cxE8zhrfCe8eoQZy4QmYwmfYvlmvd9uJw0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTM1/NzUyOTkzMy9mci9w/aG90by9pbWFnZS1n/JUMzJUE5biVDMyVB/OXIlQzMlQTllLW51/bSVDMyVBOXJpcXVl/bWVudC1kdW4tc2Fs/b24tZW50aSVDMyVB/OHJlbWVudC1tZXVi/bCVDMyVBOS5qcGc_/cz02MTJ4NjEyJnc9/MCZrPTIwJmM9al9S/T0NEcUc5MzdQWDdS/T0Jud2tQMmw4VGZK/V0hlUE5zX0FESnl0/WlZORT0',
        'title': 'Modern Apartment',
        'location': 'Zahraa El Maadi',
        'features': ['wifi', 'ac', 'balcony'],
        'price': 6000,
        'numberOfRooms': 2,
        'totalBeds': 4,
        'availableBeds': 2,
      },
      // Add more favorites as needed
    ];

    return favoriteApartments.isEmpty
        ? const Center(child: Text('No favorites yet.'))
        : ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final apartment = favoriteApartments[index];
            return ApartmentCard(
              imageUrl: apartment['imageUrl'],
              title: apartment['title'],
              location: apartment['location'],
              features: List<String>.from(apartment['features']),
              price: apartment['price'],
              numberOfRooms: apartment['numberOfRooms'],
              totalBeds: apartment['totalBeds'],
              availableBeds: apartment['availableBeds'],
              isFavorite: true,
              onFavoriteToggle: () {},
              onDetailsPressed: () {
                // Navigate to apartment details if needed
              },
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: favoriteApartments.length,
        );
  }
}
