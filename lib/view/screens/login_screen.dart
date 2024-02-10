// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/controller/auth_provider.dart';
import 'package:ecommerce/view/screens/home_screen.dart';
import 'package:ecommerce/view/screens/phone_log.dart';
import 'package:ecommerce/view/screens/signup_screen.dart';
import 'package:ecommerce/view/widgets/curve_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 222, 217, 217),
      body: Stack(
        children: [
          Column(
            children: [
              ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  color: Color.fromRGBO(190, 94, 156, 1),
                  height: 300.0,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 500,
                width: 320,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "SIGN IN ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "E-mail",
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(184, 0, 0, 0)),
                          prefixIcon: const Icon(Icons.email),
                          prefixIconColor:
                              const Color.fromARGB(175, 209, 206, 206),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(184, 0, 0, 0)),
                          prefixIcon: const Icon(Icons.email),
                          prefixIconColor:
                              const Color.fromARGB(175, 209, 206, 206),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          signIn();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(190, 94, 156, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Text(
                          "Login",
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
                          "Don't have an account?",
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SighupPage(),
                                  ));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(187, 98, 17, 113)),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Consumer<AuthProviders>(
                        builder: (context, value, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  value.singupWithGoogle();
                                },
                                child: CircleAvatar(
                                  radius: 22,
                                  backgroundImage:
                                      AssetImage("assets/google.png"),
                                ),
                              ),
                              SizedBox(width: 15),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PhoneLoginScreen(),
                                  ));
                                },
                                child: CircleAvatar(
                                  radius: 22,
                                  backgroundImage:
                                      AssetImage("assets/phone.jpg"),
                                ),
                              ),
                              SizedBox(width: 15),
                              GestureDetector(
                                onTap: () {
                                  value.signInWithGithub(context);
                                },
                                child: CircleAvatar(
                                  radius: 22,
                                  backgroundImage:
                                      AssetImage("assets/github.png"),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void signIn() async {
    final signInServices = Provider.of<AuthProviders>(context, listen: false);
    String email = emailController.text;
    String password = passwordController.text;
    User? user = await signInServices.signInWithEmail(email, password, context);
    if (user != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      print('there is some error ');
    }
  }
}
