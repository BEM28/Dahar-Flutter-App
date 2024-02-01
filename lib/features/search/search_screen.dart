import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:submisi_2/services/helper/result_state.dart';
import 'package:submisi_2/services/provider/internet_check.dart';
import 'package:submisi_2/sharred_widget/anim_text.dart';
import 'package:submisi_2/sharred_widget/card_resto.dart';
import 'package:submisi_2/sharred_widget/card_resto_shimmer.dart';
import 'package:submisi_2/sharred_widget/icon_rounded.dart';
import 'package:submisi_2/sharred_widget/no_connectivity.dart';
import 'package:submisi_2/sharred_widget/text_field.dart';
import 'package:submisi_2/constant/resto_themes.dart';
import 'package:submisi_2/services/provider/restaurant_search.dart';

class SeacrhRestaurant extends StatefulWidget {
  const SeacrhRestaurant({super.key});

  @override
  State<SeacrhRestaurant> createState() => _SeacrhRestaurantState();
}

class _SeacrhRestaurantState extends State<SeacrhRestaurant> {
  @override
  void initState() {
    super.initState();
    Provider.of<InternetConnectionProvider>(context, listen: false)
        .checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    InternetConnectionProvider data =
        Provider.of<InternetConnectionProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => RestaurantSearchProvider(),
      child: Consumer<RestaurantSearchProvider>(
          builder: (context, provider, child) {
        return data.isOnline == false
            ? const NoConnectivity()
            : SafeArea(
                child: Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: RestoThemes.backgroundColor,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(15.h),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: IconRound(
                                icons: Icons.arrow_back_rounded,
                                onTap: () => Navigator.pop(context),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
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
                          ],
                        ),
                      ),
                    ),
                    body: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: provider.queries.isEmpty
                            ? const SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Center(
                                      child: AnimWithText(
                                        lottie:
                                            'assets/Lottie/searchLoading.json',
                                        text2: 'Find a Restaurant',
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : _buildList())),
              );
      }),
    );
  }
}

Widget _buildList() {
  return Consumer<RestaurantSearchProvider>(
    builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            return const CardRestoShimmer();
          },
        );
      } else if (state.state == ResultState.hasData) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.searchResult.length,
          itemBuilder: (context, index) {
            var data = state.searchResult[index];
            return CardResto(
              restaurantList: data,
              tab: 3,
            );
          },
        );
      } else if (state.state == ResultState.noData) {
        return Center(
          child: Material(
            child: Text(state.message),
          ),
        );
      } else if (state.state == ResultState.error) {
        return Center(
          child: Material(
            child: Text(state.message),
          ),
        );
      } else {
        return const Center(
          child: Material(
            child: Text(''),
          ),
        );
      }
    },
  );
}
