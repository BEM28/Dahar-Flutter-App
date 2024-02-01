import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetConnectionProvider with ChangeNotifier {
  bool _isOnline = false;

  bool get isOnline => _isOnline;

  Future<void> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      _isOnline = true;
    } else {
      _isOnline = false;
    }
    notifyListeners();
  }
}
