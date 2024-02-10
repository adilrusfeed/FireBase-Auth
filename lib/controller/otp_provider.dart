import 'package:flutter/material.dart';

class OtpProvider extends ChangeNotifier {
  String? otpcode;

  otpSetter(value) {
    otpcode = value;
    notifyListeners();
  }
}
