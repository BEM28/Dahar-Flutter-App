import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:submisi_2/constant/resto_themes.dart';
import 'package:submisi_2/services/helper/result_state.dart';
import 'package:submisi_2/services/provider/internet_check.dart';
import 'package:submisi_2/services/provider/retaurant_favorite.dart';
import 'package:submisi_2/sharred_widget/card_resto.dart';
import 'package:submisi_2/sharred_widget/card_resto_shimmer.dart';
import 'package:submisi_2/sharred_widget/icon_rounded.dart';
import 'package:submisi_2/sharred_widget/no_connectivity.dart';
import 'package:submisi_2/sharred_widget/text_field.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: RetaurantFavoriteProvider(),
      child: Consumer2<InternetConnectionProvider, RetaurantFavoriteProvider>(
        builder: (context, internetData, provider, child) {
          return SafeArea(
            child: internetData.isOnline == false
                ? const NoConnectivity()
                : Scaffold(
                    backgroundColor: RestoThemes.backgroundColor,
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: RestoThemes.backgroundColor,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(15.h),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: RestoThemes.lightPink,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  height: 70.h,
                                  width: 340.w,
                                  child: MyTextField(
                                    hintText: 'Restaurant',
                                    onChanged: provider.updateQuery,
                                  )),
                              Positioned(
                                right: 8,
                                child: IconRound(
                                  icons: Icons.search_rounded,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.h),
                          Text("Your Favorite Restaurants",
                              style: RestoThemes.heading1),
                          SizedBox(height: 8.h),
                          Expanded(
                            child: _buildList(provider),
                          )
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildList(RetaurantFavoriteProvider provider) {
    if (provider.state == ResultState.loading) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return const CardRestoShimmer();
        },
      );
    } else if (provider.state == ResultState.hasData) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: provider.likedRestaurants.length,
        itemBuilder: (context, index) {
          var data = provider.likedRestaurants[index];
          return CardResto(
            restaurantList: data,
            tab: 1,
          );
        },
      );
    } else if (provider.state == ResultState.noData) {
      return Center(
        child: Material(
          child: Text(provider.message),
        ),
      );
    } else if (provider.state == ResultState.error) {
      return Center(
        child: Material(
          child: Text(provider.message),
        ),
      );
    } else {
      return const Center(
        child: Material(
          child: Text(''),
        ),
      );
    }
  }
}
