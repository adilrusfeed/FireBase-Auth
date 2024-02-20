// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:ecommerce/service/auth_services.dart';
import 'package:ecommerce/view/widgets/settings/drawer.dart';
import 'package:ecommerce/view/widgets/settings/exit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class DrawerHeaderWidget extends StatelessWidget {
  FirebaseAuthServices auth = FirebaseAuthServices();
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Column(
        children: [
          Text(auth.auth.currentUser!.email ?? '',
              style: GoogleFonts.montserrat(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 12,
              )),
          SizedBox(
              // height: 150,
              // child: Lottie.asset("assets/phone.jpg"),

              // Lottie.asset(
              //   'assets/phone.jpg',
              //   width: 250,
              // ),
              ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => AboutScreen(),
              // ));
            },
            child: DrawerItem(text: "About", icon: Icons.info),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => TermsScreen(),
              // ));
            },
            child: DrawerItem(
              text: "Terms and Conditions",
              icon: Icons.document_scanner_rounded,
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Log out..?',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    backgroundColor: Color.fromARGB(255, 24, 30, 41),
                    actions: [
                      TextButton(
                          onPressed: () {
                            FirebaseAuthServices().signOut();
                            Navigator.pop(context);
                          },
                          child: Text('Yes')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('No')),
                    ],
                  );
                },
              );
            },
            child: DrawerItem(text: "Signout", icon: Icons.logout),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              exitpopup(context);
            },
            child: DrawerItem(text: "Exit", icon: Icons.exit_to_app),
          ),
          Divider(),
          SizedBox(height: 30),
          Align(
            alignment: Alignment.center,
            child: Text(
              "shopify",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
