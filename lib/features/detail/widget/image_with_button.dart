import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:submisi_2/features/main/main_screen.dart';
import 'package:submisi_2/services/model/restaurant_list.dart';
import 'package:submisi_2/services/provider/retaurant_favorite.dart';
import 'package:submisi_2/sharred_widget/icon_and_text.dart';
import 'package:submisi_2/sharred_widget/icon_rounded.dart';
import 'package:submisi_2/features/detail/widget/like_button.dart';

class ImageWithButton extends StatefulWidget {
  final RestaurantList restaurantList;
  final int tab;
  const ImageWithButton(
      {super.key, required this.restaurantList, required this.tab});

  @override
  State<ImageWithButton> createState() => _ImageWithButtonState();
}

class _ImageWithButtonState extends State<ImageWithButton> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: RetaurantFavoriteProvider()
        ..isRestaurantLiked(widget.restaurantList.id),
      child: Consumer<RetaurantFavoriteProvider>(
          builder: (context, provider, child) {
        return Stack(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/large/${widget.restaurantList.pictureId}',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IconRound(
                            icons: Icons.arrow_back_rounded,
                            onTap: () {
                              if (widget.tab == 3) {
                                Navigator.pop(context);
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainScreen(
                                              tab: widget.tab,
                                            )));
                              }
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: MyLikeButton(
                            isLiked: provider.isLiked,
                            onTap: () {
                              provider
                                  .onLikeButtonTapped(widget.restaurantList);
                              provider.loadFavorite();
                            }),
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 35,
                    right: 20,
                    child: SizedBox(
                      width: 80.w,
                      child: IconAndText(
                        icon: Icons.star_border_rounded,
                        text: widget.restaurantList.rating.toString(),
                      ),
                    ),
                  ),
                ])),
          ],
        );
      }),
    );
  }
}
