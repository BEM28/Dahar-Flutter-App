import 'dart:ui';
import 'dart:isolate';
import 'package:submisi_2/main.dart';
import 'package:submisi_2/services/helper/notification.dart';
import 'package:submisi_2/services/model/restaurant_list.dart';
import 'package:submisi_2/services/network/api_client.dart';

final ReceivePort port = ReceivePort();
String baseUrl = 'https://restaurant-api.dicoding.dev';
final RestaurantApiClient apiClient = RestaurantApiClient();
final NotificationHelper notificationHelper = NotificationHelper();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    var data = await apiClient.fetchRestaurants('$baseUrl/list');
    try {
      final restaurant = (data as List<dynamic>)
          .map((data) => RestaurantList.fromJson(data))
          .toList();

      await notificationHelper.showNotification(
          flutterLocalNotificationsPlugin, restaurant);
      _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
      _uiSendPort?.send(null);
    } catch (e) {
      print("Error: $e");
    }
  }
}
