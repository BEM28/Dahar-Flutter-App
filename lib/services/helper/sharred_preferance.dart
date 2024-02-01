import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static const String _keyisScheduled = 'scheduled';

  //schedulling
  Future<void> saveSchedulingStatus(bool isScheduled) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_keyisScheduled, isScheduled);
  }

  Future<bool?> getSchedulingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyisScheduled);
  }
}
