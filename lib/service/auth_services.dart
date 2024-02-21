import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/user_model.dart';
import 'package:ecommerce/view/widgets/login/customer_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<UserCredential> signUpWithEmailAndPassword(
    String email,
    String pass,
    String name,
  ) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      final UserModel userdata =
          UserModel(email: email, name: name, uid: user.user!.uid);

      firestore.collection('users').doc(user.user!.uid).set(userdata.toJson());
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password, context) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      firestore.collection('users').doc(userCredential.user!.uid).set(
          {'uid': userCredential.user!.uid, 'email': email},
          SetOptions(merge: true));
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // ignore: unused_local_variable
      String errorcode = "error singIn";
      if (e.code == 'wrong-password' || e.code == 'user-not-found') {
        errorcode = "Icorrect email or password";
      } else if (e.code == 'user-disabled') {
        errorcode = "User not found";
      } else {
        errorcode = e.code;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorcode)));
      return null;
    }
  }

  singinWithGoogle() async {
    try {
      final GoogleSignInAccount? guser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gauth = await guser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: gauth.accessToken, idToken: gauth.idToken);
      UserCredential credentialUser =
          await auth.signInWithCredential(credential);
      User? googleuser = credentialUser.user;
      final UserModel userdata = UserModel(
          email: googleuser!.email,
          name: googleuser.displayName,
          uid: googleuser.uid);
      firestore.collection("users").doc(googleuser.uid).set(userdata.toJson());
      return credentialUser;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  void signInwithPhone(
      String phonenumber, context, String name, String email) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phonenumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            var credential =
                await auth.signInWithCredential(phoneAuthCredential);
            final UserModel userdata = UserModel(
                email: email,
                name: name,
                uid: credential.user!.uid,
                phonenumber: credential.user!.phoneNumber);
            firestore
                .collection("users")
                .doc(credential.user!.uid)
                .set(userdata.toJson());
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, resendtoken) {
            showDialog(
              context: context,
              builder: (context) {
                return CustomAlertDialog(
                  veridicationId: verificationId,
                );
              },
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  void verifyOtp(
      {required String verificationId,
      required String otp,
      required Function onSuccess}) async {
    try {
      PhoneAuthCredential cred = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      User? user = (await auth.signInWithCredential(cred)).user;

      if (user != null) {
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  signInWithGithub(context) async {
    GithubAuthProvider githubAuthProvider = GithubAuthProvider();
    try {
      UserCredential user = await auth.signInWithProvider(githubAuthProvider);
      User gituser = user.user!;
      final UserModel userdata = UserModel(
          email: gituser.email, name: gituser.displayName, uid: gituser.uid);
      firestore.collection("users").doc(gituser.uid).set(userdata.toJson());
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signOut() async {
    final GoogleSignIn google = GoogleSignIn();

    try {
      await auth.signOut();
      await google.signOut();
    } catch (e) {
      print("this is the error r$e");
    }
  }
}
