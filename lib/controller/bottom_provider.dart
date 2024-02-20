import 'package:flutter/material.dart';

class BottomBarProvider extends ChangeNotifier {
  int currentIndex = 0;
  navigatePage(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
