import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:submisi_2/constant/resto_themes.dart';
import 'package:provider/provider.dart';
import 'package:submisi_2/features/splash/splash_screen.dart';
import 'package:submisi_2/services/helper/background_service.dart';
import 'package:submisi_2/services/helper/notification.dart';
import 'package:submisi_2/services/provider/internet_check.dart';
import 'package:submisi_2/services/provider/restaurant_list.dart';
import 'package:submisi_2/services/provider/restaurant_detail.dart';
import 'package:submisi_2/services/provider/restaurant_search.dart';
import 'package:submisi_2/services/provider/retaurant_favorite.dart';
import 'package:submisi_2/services/provider/scheduling_provider.dart';
import 'package:submisi_2/services/provider/tab_index.dart';
import 'package:flutter/services.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => SchedulingProvider()),
      ChangeNotifierProvider(create: (context) => TabIndexProvider()),
      ChangeNotifierProvider(create: (context) => InternetConnectionProvider()),
      ChangeNotifierProvider(create: (context) => RestaurantListProvider()),
      ChangeNotifierProvider(create: (context) => RetaurantFavoriteProvider()),
      ChangeNotifierProvider(create: (context) => RestaurantDetailProvider()),
      ChangeNotifierProvider(create: (context) => RestaurantSearchProvider()),
    ], child: const MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'Dahar',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: RestoThemes.backgroundColor,
            primarySwatch: Colors.orange,
            useMaterial3: true,
          ),
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
