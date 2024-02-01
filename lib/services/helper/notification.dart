import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:submisi_2/features/detail/detail_screen.dart';
import 'package:submisi_2/services/model/restaurant_list.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;
  NotificationHelper._internal() {
    _instance = this;
  }
  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) async {
      final payload = details.payload;
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      List<RestaurantList> restaurant) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "restaurant channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var randomIndex = Random().nextInt(restaurant.length);
    var randomRestaurant = restaurant[randomIndex];

    var titleNotification = "<b>Recommended Restaurant for you!</b>";
    var titleRestaurants = randomRestaurant.name;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleRestaurants, platformChannelSpecifics,
        payload: json.encode(randomRestaurant.toJson()));
  }

  void configureSelectNotificationSubject(BuildContext context) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestaurantList.fromJson(json.decode(payload));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                      tab: 3,
                      restaurantList: data,
                    )));
      },
    );
  }
}
