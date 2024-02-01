import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:submisi_2/constant/resto_themes.dart';
import 'package:submisi_2/features/favorite/favorite_screen.dart';
import 'package:submisi_2/features/home/home_screen.dart';
import 'package:submisi_2/features/setting/setting_screen.dart';
import 'package:submisi_2/services/helper/notification.dart';
import 'package:submisi_2/services/provider/tab_index.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.tab});
  final int? tab;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(context);
    if (widget.tab != null) {
      Provider.of<TabIndexProvider>(context, listen: false)
          .setIndex2(widget.tab!);
    }
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TabIndexProvider>(
        builder: (context, tabIndexProvider, child) {
          switch (tabIndexProvider.currentIndex) {
            case 0:
              return const HomePage();
            case 1:
              return const FavoriteScreen();
            case 2:
              return const SettingScreen();

            default:
              return const HomePage();
          }
        },
      ),
      bottomNavigationBar: Consumer<TabIndexProvider>(
        builder: (context, tabIndexProvider, child) {
          return Container(
            height: 70.h,
            decoration: BoxDecoration(
              boxShadow: RestoThemes.restoShadow(),
              color: RestoThemes.white,
            ), // Set the background color
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _barItems(
                  index: tabIndexProvider.currentIndex,
                  row: 0,
                  icons: Icons.home_rounded,
                  onTap: () {
                    tabIndexProvider.setIndex(0);
                  },
                ),
                _barItems(
                  index: tabIndexProvider.currentIndex,
                  row: 1,
                  icons: Icons.favorite,
                  onTap: () {
                    tabIndexProvider.setIndex(1);
                  },
                ),
                _barItems(
                  index: tabIndexProvider.currentIndex,
                  row: 2,
                  icons: Icons.settings,
                  onTap: () {
                    tabIndexProvider.setIndex(2);
                  },
                ),

                // Add more icons/buttons for additional tabs
              ],
            ),
          );
        },
      ),
    );
  }
}

class _barItems extends StatelessWidget {
  void Function()? onTap;
  final IconData? icons;
  final int? index;
  final int? row;

  _barItems({
    super.key,
    this.onTap,
    this.index,
    this.row,
    this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100.w,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: index == row
                ? RestoThemes.selectedColor
                : RestoThemes.unSelectedColor,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Icon(
          icons,
          size: 35.sp,
          color: index == row ? RestoThemes.orange : RestoThemes.blueBlack,
        ),
      ),
    );
  }
}
