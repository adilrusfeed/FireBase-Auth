// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SplashProvider extends ChangeNotifier {
//   bool _isLoading = true;
//   bool get isLoading => _isLoading;

//   SplashProvider() {
//     _init();
//   }

//   Future<void> _init() async {
//     await _initializeSharedPreferences();
//     await Future.delayed(Duration(seconds: 2));
//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<void> _initializeSharedPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//   }
// }
