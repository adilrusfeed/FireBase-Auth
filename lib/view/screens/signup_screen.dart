// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:ecommerce/service/auth_services.dart';
import 'package:ecommerce/view/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SighupPage extends StatefulWidget {
  SighupPage({super.key});

  @override
  State<SighupPage> createState() => _SighupPageState();
}

class _SighupPageState extends State<SighupPage> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 222, 217, 217),
      body: Center(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: 500,
            width: 320,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SIGN UP ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle:
                          const TextStyle(color: Color.fromARGB(184, 0, 0, 0)),
                      prefixIcon: const Icon(Icons.email),
                      prefixIconColor: const Color.fromARGB(175, 209, 206, 206),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 186, 11, 11)),
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "E-mail",
                      hintStyle:
                          const TextStyle(color: Color.fromARGB(184, 0, 0, 0)),
                      prefixIcon: const Icon(Icons.email),
                      prefixIconColor: const Color.fromARGB(175, 209, 206, 206),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 223, 27, 27)),
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle:
                          const TextStyle(color: Color.fromARGB(184, 0, 0, 0)),
                      prefixIcon: const Icon(Icons.email),
                      prefixIconColor: const Color.fromARGB(175, 209, 206, 206),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 220, 31, 31)),
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
                ElevatedButton(
                    onPressed: () {
                      signUp();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(190, 94, 156, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(height: 20),
                Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "or",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "already have an account?",
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Logg in",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(187, 98, 17, 113)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp() async {
    String name = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    UserCredential? user =
        await _auth.signUpWithEmailAndPassword(email, password, name);
    if (user != null) {
      _showSuccessDialog();
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginPage()));
      });
    } else {
      print('there is some error ');
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            "Sign Up Successful",
            style: TextStyle(color: Colors.white),
          ),
          content: const Text("You have signed up successfully!",
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
