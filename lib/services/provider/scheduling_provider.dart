import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:submisi_2/services/helper/background_service.dart';
import 'package:submisi_2/services/helper/datetime_helper.dart';
import 'package:submisi_2/services/helper/sharred_preferance.dart';

class SchedulingProvider with ChangeNotifier {
  final SharedPreferencesManager _sharedPreferencesManager =
      SharedPreferencesManager();
  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  Future<void> loadScheduling() async {
    final data = await _sharedPreferencesManager.getSchedulingStatus();
    if (data == null) {
      _isScheduled = false;
    } else {
      _isScheduled = data;
    }
    notifyListeners();
  }

  Future<bool> scheduledRestaurants(bool value) async {
    _isScheduled = value;
    await _sharedPreferencesManager.saveSchedulingStatus(value);
    if (_isScheduled) {
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
