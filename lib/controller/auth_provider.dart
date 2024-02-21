import 'package:ecommerce/service/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProviders extends ChangeNotifier {
  Future<UserCredential>? user;
  FirebaseAuthServices service = FirebaseAuthServices();
  String? otpcode;
  signInWithEmail(String email, String password, BuildContext context) {
    return service.signInWithEmailAndPassword(email, password, context);
  }

  signUpWithEmail(String email, String password, String name) {
    return service.signInWithEmailAndPassword(email, password, name);
  }

  singupWithGoogle() {
    return service.singinWithGoogle();
  }

  signInWithGithub(context) {
    return service.signInWithGithub(context);
  }

  otpSetter(value) {
    otpcode = value;
    notifyListeners();
  }

  void signInWithPhone(phonenumber, context, name, email) async {
    service.signInwithPhone(phonenumber, context, name, email);
    notifyListeners();
  }
}
