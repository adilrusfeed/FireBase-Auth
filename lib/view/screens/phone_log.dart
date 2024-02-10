import 'package:ecommerce/service/auth_services.dart';
import 'package:ecommerce/view/screens/login_screen.dart';
import 'package:ecommerce/view/widgets/phone_field.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneLoginScreen extends StatelessWidget {
  PhoneLoginScreen({super.key});

  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController otpcontroller = TextEditingController();
  final FirebaseAuthServices service = FirebaseAuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body:
          // NotificationListener<ScrollNotification>(
          //   onNotification: (notification) {
          //     if (notification is ScrollUpdateNotification) {
          //       final bottomInset = MediaQuery.of(context).viewInsets.bottom;
          //       if (bottomInset > 0) {
          //         Scrollable.ensureVisible(
          //           notification.context!,
          //           alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
          //         );
          //       }
          //     }
          //     return true;
          //   },
          //child:
          Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              "assets/image.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.9),
                  Colors.black.withOpacity(1),
                ])),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200, left: 20, right: 100),
            child: Text(
              "OTP Verification",
              style: GoogleFonts.comfortaa(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 340),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  CustomPhoneField(
                      controller: phonecontroller, hinttext: "Phone"),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: CustomTextField(
                        controller: namecontroller,
                        hinttext: "Name",
                        fillcolor: const Color.fromARGB(255, 255, 255, 255)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: CustomTextField(
                        controller: emailcontroller,
                        hinttext: "Email",
                        fillcolor: const Color.fromARGB(255, 255, 255, 255)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'We will send you a ',
                          style: GoogleFonts.comfortaa(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "One Time Password",
                          style: GoogleFonts.comfortaa(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    " on your mobile number",
                    style: GoogleFonts.comfortaa(color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: InkWell(
                      splashColor: Colors.black,
                      borderRadius: BorderRadius.circular(25),
                      onTap: () {
                        String countrycode = "+91";
                        String phonenumber = countrycode + phonecontroller.text;
                        service.signInwithPhone(phonenumber, context,
                            namecontroller.text, emailcontroller.text);
                      },
                      child: Container(
                        width: 180,
                        height: 50,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 167, 15, 15)
                                .withOpacity(0.8),
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                            child: Text(
                          'Generate Otp',
                          style: GoogleFonts.comfortaa(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
