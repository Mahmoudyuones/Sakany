import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakany/core/resources/color_manager.dart';
import 'package:sakany/core/utils/ui_utils.dart';
import 'package:sakany/core/widgets/appartment_card.dart';
import 'package:sakany/features/home/apartment_details_screen.dart';
import 'package:sakany/features/home/apartment_service.dart';
import 'package:sakany/features/home/models/apartment_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  final ScrollController _scrollController = ScrollController();
  List<ApartmentModel> apartments = [];
  int _skip = 0;
  final int _take = 10;
  bool _isLoading = false;
  bool _hasMore = true;

  String? location;
  double? price;

  @override
  void initState() {
    super.initState();
    _fetchApartments();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !_isLoading &&
          _hasMore) {
        _fetchApartments();
      }
    });
  }

  List<ApartmentModel> _filterApartments(List<ApartmentModel> list) {
    return list.where((apartment) {
      final totalPrice = apartment.rooms
          .expand((r) => r.beds)
          .map((b) => b.price)
          .fold<double>(0, (sum, price) => sum + price);

      final matchesLocation =
          location == null ||
          location!.isEmpty ||
          apartment.location.toLowerCase() == location!.toLowerCase();
      final matchesPrice = price == null || totalPrice <= price!;

      return matchesLocation && matchesPrice;
    }).toList();
  }

  Future<void> _fetchApartments() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    try {
      final newApartments = await ApartmentService.fetchApartments(
        skip: _skip,
        take: _take,
      );

      final filteredApartments = _filterApartments(newApartments);

      setState(() {
        apartments.addAll(filteredApartments);
        _skip += _take;
        if (newApartments.length < _take) {
          _hasMore = false;
        }
      });
    } catch (e) {
      debugPrint('Error fetching apartments: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _applyFilter({String? newLocation, double? newPrice}) {
    setState(() {
      location = newLocation;
      price = newPrice;
      apartments.clear();
      _skip = 0;
      _hasMore = true;
    });
    _fetchApartments();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () async {
                UIUtils.showFilterDialog(
                  context,
                  onApply: (selectedLocation, maxPrice) {
                    _applyFilter(
                      newLocation: selectedLocation ?? '',
                      newPrice: maxPrice,
                    );
                    setState(() {});
                  },
                );
              },
              child: SizedBox(
                height: 40.h,
                width: 40.w,
                child: Image.asset('assets/icons/Filter.png'),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child:
                apartments.isEmpty && !_isLoading
                    ? const Center(
                      child: Text(
                        'No data available',
                        style: TextStyle(
                          fontSize: 18,
                          color: ColorManager.grey,
                        ),
                      ),
                    )
                    : ListView.separated(
                      controller: _scrollController,
                      itemCount: apartments.length + (_hasMore ? 3 : 0),
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        if (index < apartments.length) {
                          final apartment = apartments[index];
                          final totalBeds = apartment.rooms.fold<int>(
                            0,
                            (sum, room) => sum + room.beds.length,
                          );
                          final totalPrice = apartment.rooms
                              .expand((r) => r.beds)
                              .map((b) => b.price)
                              .fold<double>(0, (sum, price) => sum + price);

                          return ApartmentCard(
                            features: apartment.isWifi ? ['wifi'] : [],
                            imageUrl: apartment.mainImage,
                            title: apartment.apartmentTitle,
                            location: apartment.location,
                            price: totalPrice,
                            onDetailsPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => ApartmentDetailsScreen(
                                        apartment: apartment,
                                      ),
                                ),
                              );
                            },
                            numberOfRooms: apartment.rooms.length,
                            totalBeds: totalBeds,
                            isFavorite: false,
                            onFavoriteToggle: () {},
                          );
                        } else {
                          return Skeletonizer(
                            enabled: _isLoading,
                            child: ApartmentCard(
                              imageUrl: 'placeholder_image_url',
                              title: 'Loading...',
                              location: 'Loading...',
                              numberOfRooms: 0,
                              totalBeds: 0,
                              features: [],
                              price: 0,
                              isFavorite: false,

                              onFavoriteToggle: () {},
                              onDetailsPressed: () {},
                            ),
                          );
                        }
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
