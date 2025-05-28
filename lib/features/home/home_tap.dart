import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakany/core/utils/ui_utils.dart';
import 'package:sakany/core/widgets/appartment_card.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  // Track favorites for each apartment by index
  late List<bool> _favorites;

  @override
  void initState() {
    super.initState();
    _favorites = List.generate(10, (index) => false); // 10 dummy apartments
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
              onTap: () {
                UIUtils.showFilterDialog(context);
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
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ApartmentCard(
                  features: ['wifi', 'elevator', 'ac'],
                  imageUrl:
                      'https://imgs.search.brave.com/FckAPpfU1cxE8zhrfCe8eoQZy4QmYwmfYvlmvd9uJw0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTM1/NzUyOTkzMy9mci9w/aG90by9pbWFnZS1n/JUMzJUE5biVDMyVB/OXIlQzMlQTllLW51/bSVDMyVBOXJpcXVl/bWVudC1kdW4tc2Fs/b24tZW50aSVDMyVB/OHJlbWVudC1tZXVi/bCVDMyVBOS5qcGc_/cz02MTJ4NjEyJnc9/MCZrPTIwJmM9al9S/T0NEcUc5MzdQWDdS/T0Jud2tQMmw4VGZK/V0hlUE5zX0FESnl0/WlZORT0',
                  title: 'Apartment Title',
                  location: 'Seed Location',
                  price: 5000,
                  onDetailsPressed: () {},
                  numberOfRooms: 3,
                  totalBeds: 10,
                  availableBeds: 5,
                  isFavorite: _favorites[index],
                  onFavoriteToggle: () {
                    setState(() {
                      _favorites[index] = !_favorites[index];
                    });
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
