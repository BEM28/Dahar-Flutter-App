import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:submisi_2/features/main/main_screen.dart';
import 'package:submisi_2/services/helper/result_state.dart';
import 'package:submisi_2/services/model/restaurant_list.dart';
import 'package:submisi_2/sharred_widget/anim_text.dart';
import 'package:submisi_2/sharred_widget/floatting_button.dart';
import 'package:submisi_2/sharred_widget/icon_and_text.dart';
import 'package:submisi_2/sharred_widget/menu_card.dart';
import 'package:submisi_2/sharred_widget/read_more.dart';
import 'package:submisi_2/sharred_widget/review_card.dart';
import 'package:submisi_2/sharred_widget/text_field.dart';
import 'package:submisi_2/constant/resto_themes.dart';
import 'package:submisi_2/features/detail/widget/bar_modal_bottom.dart';
import 'package:submisi_2/features/detail/widget/image_with_button.dart';
import 'package:submisi_2/services/model/restaurant_detail.dart';
import 'package:submisi_2/services/provider/restaurant_detail.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {super.key, required this.restaurantList, required this.tab});

  final RestaurantList restaurantList;
  final int tab;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<RestaurantDetailProvider>(context, listen: false)
        .getRestaurantDetail(widget.restaurantList.id);
    Provider.of<RestaurantDetailProvider>(context, listen: false)
        .getRestaurantReview(widget.restaurantList.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, data, _) {
        if (data.state == ResultState.loading) {
          return Scaffold(
              backgroundColor: RestoThemes.backgroundColor,
              body: Center(
                child: SizedBox(
                    width: 60.w,
                    height: 60.w,
                    child: const CircularProgressIndicator(
                        color: RestoThemes.orange)),
              ));
        } else if (data.state == ResultState.hasData) {
          return SafeArea(
            child: Scaffold(
                backgroundColor: RestoThemes.backgroundColor,
                floatingActionButton: MyFloatting(onTap: () {
                  postReview(context, widget.restaurantList.id).then((value) {
                    data.getRestaurantReview(widget.restaurantList.id);
                  });
                }),
                body: data.restaurantDetail == null
                    ? const AnimWithText(
                        lottie: 'assets/Lottie/whiteAnim.json',
                      )
                    : PopScope(
                        canPop: false,
                        onPopInvoked: (bool didPop) {
                          if (didPop) {
                            return;
                          }
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
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15.h),
                                ImageWithButton(
                                  tab: widget.tab,
                                  restaurantList: widget.restaurantList,
                                ),
                                Text(data.restaurantDetail!.name,
                                    style: RestoThemes.heading1),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(data.restaurantDetail!.city,
                                        style: RestoThemes.heading2),
                                    Text(data.restaurantDetail!.address,
                                        style: RestoThemes.heading2),
                                  ],
                                ),
                                Text("Description :",
                                    style: RestoThemes.heading1),
                                ReadMore(
                                    text: data.restaurantDetail!.description),
                                SizedBox(height: 8.w),
                                SizedBox(
                                  width: 200.w,
                                  child: IconAndText(
                                    icon: Icons.fastfood_sharp,
                                    text: 'See The Menus',
                                    onTap: () {
                                      menus(context, data.restaurantDetail!);
                                    },
                                  ),
                                ),
                                Text("Review : ", style: RestoThemes.heading1),
                                _buildListReview(),
                              ],
                            ),
                          ),
                        ),
                      )),
          );
        } else if (data.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(data.message),
            ),
          );
        } else if (data.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(data.message),
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

  Future<dynamic> postReview(BuildContext context, String id) {
    final name = TextEditingController();
    final review = TextEditingController();
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              height: 350.h,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text('Review :', style: RestoThemes.heading1),
                    SizedBox(height: 10.h),
                    MyTextField(
                      hintText: 'Name',
                      controller: name,
                    ),
                    SizedBox(height: 10.h),
                    MyTextField(
                      hintText: 'Review',
                      controller: review,
                    ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {
                        if (name.text.isNotEmpty || review.text.isNotEmpty) {
                          RestaurantDetailProvider reviewData =
                              Provider.of<RestaurantDetailProvider>(context,
                                  listen: false);
                          reviewData
                              .addReview(id, name.text, review.text)
                              .then((value) {
                            Navigator.pop(context);
                          });
                        }
                      },
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            boxShadow: RestoThemes.iconShadow(),
                            borderRadius: BorderRadius.circular(20.r),
                            color: RestoThemes.orange,
                          ),
                          child: Center(
                            child: Text('Save', style: RestoThemes.heading1),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<dynamic> menus(BuildContext context, RestaurantDetail data) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (BuildContext context) {
        String actived = 'Foods';
        List datas = data.menus.foods;

        return StatefulBuilder(
            builder: (BuildContext context, StateSetter state) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 500.h,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 55.h,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        border:
                            Border.all(color: RestoThemes.orange, width: 3.w)),
                    child: Row(
                      children: [
                        Expanded(
                            child: BarModal(
                          title: 'Foods',
                          active: actived,
                          onTap: () {
                            if (actived != 'Foods') {
                              state(() {
                                actived = 'Foods';
                                datas = data.menus.foods;
                              });
                              (() {});
                            }
                          },
                        )),
                        SizedBox(
                            width: 160.w,
                            child: BarModal(
                              title: 'Drinks',
                              active: actived,
                              onTap: () {
                                if (actived != 'Drinks') {
                                  state(() {
                                    actived = 'Drinks';
                                    datas = data.menus.drinks;
                                  });
                                }
                              },
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: datas.length,
                      itemBuilder: (context, index) {
                        var items = datas[index];
                        return MenuCard(
                          name: items.name,
                        );
                      },
                    ),
                  ),
                ],
              ));
        });
      },
    );
  }

  Widget _buildListReview() {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return SizedBox(
              width: 60.w,
              height: 60.w,
              child:
                  const CircularProgressIndicator(color: RestoThemes.orange));
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.customerReview.length,
            itemBuilder: (context, index) {
              var data = state.customerReview[index];
              return ReviewCard(
                name: data.name,
                date: data.date,
                comment: data.review,
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
}
