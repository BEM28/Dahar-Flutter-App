import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:submisi_2/features/detail/detail_screen.dart';
import 'package:submisi_2/services/model/restaurant_list.dart';
import 'package:submisi_2/sharred_widget/icon_and_text.dart';
import 'package:submisi_2/constant/resto_themes.dart';

class CardResto extends StatelessWidget {
  const CardResto({super.key, required this.restaurantList, required this.tab});
  final RestaurantList restaurantList;
  final int tab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                      tab: tab,
                      restaurantList: restaurantList,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/large/${restaurantList.pictureId}',
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: RestoThemes.lightPink,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(restaurantList.name, style: RestoThemes.heading1),
                    Text(restaurantList.city, style: RestoThemes.heading2),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 35,
              right: 20,
              child: SizedBox(
                width: 80.w,
                child: IconAndText(
                  icon: Icons.star_border_rounded,
                  text: restaurantList.rating.toString(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
