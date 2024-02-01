import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:submisi_2/constant/resto_themes.dart';
import 'package:submisi_2/features/search/search_screen.dart';
import 'package:submisi_2/services/helper/result_state.dart';
import 'package:submisi_2/services/provider/internet_check.dart';
import 'package:submisi_2/sharred_widget/card_resto.dart';
import 'package:submisi_2/sharred_widget/card_resto_shimmer.dart';
import 'package:submisi_2/sharred_widget/icon_rounded.dart';
import 'package:submisi_2/sharred_widget/no_connectivity.dart';
import 'package:submisi_2/services/provider/restaurant_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        create: (context) => RestaurantListProvider(),
        child: Consumer<RestaurantListProvider>(
            builder: (context, provider, child) {
          return SafeArea(
            child: data.isOnline == false
                ? const NoConnectivity()
                : Scaffold(
                    backgroundColor: RestoThemes.backgroundColor,
                    appBar: AppBar(
                      scrolledUnderElevation: 0,
                      toolbarHeight: 80.h,
                      automaticallyImplyLeading: false,
                      backgroundColor: const Color.fromARGB(98, 249, 244, 241),
                      title: Text('Dahar', style: RestoThemes.title),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: IconRound(
                            icons: Icons.search,
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SeacrhRestaurant(),
                                )),
                          ),
                        )
                      ],
                    ),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Recommended Restaurant',
                              style: RestoThemes.heading1),
                          SizedBox(height: 8.h),
                          Expanded(child: _buildList())
                        ],
                      ),
                    ),
                  ),
          );
        }));
  }
}

Widget _buildList() {
  return Consumer<RestaurantListProvider>(
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
          itemCount: state.restaurants.length,
          itemBuilder: (context, index) {
            var data = state.restaurants[index];
            return CardResto(
              restaurantList: data,
              tab: 0,
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
