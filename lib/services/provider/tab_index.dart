import 'package:flutter/material.dart';

class TabIndexProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void setIndex2(int index) {
    _currentIndex = index;
  }
}
