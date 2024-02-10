import 'package:ecommerce/controller/otp_provider.dart';
import 'package:ecommerce/service/auth_services.dart';
import 'package:ecommerce/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class CustomAlertDialog extends StatelessWidget {
  final String veridicationId;
  CustomAlertDialog({
    required this.veridicationId,
    super.key,
  });
  final TextEditingController otpcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 138, 138, 138),
      actions: [
        // CustomTextField(
        //   controller: otpcontroller,
        //   hinttext: "OTP",
        //   fillcolor: const Color.fromRGBO(43, 40, 53, 1),
        // ),
        const SizedBox(
          height: 50,
        ),
        Pinput(
          length: 6,
          showCursor: true,
          defaultPinTheme: PinTheme(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: const Color.fromARGB(255, 255, 255, 255))),
          ),
          onChanged: (value) {
            Provider.of<OtpProvider>(context, listen: false).otpSetter(value);
          },
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            String userotp =
                Provider.of<OtpProvider>(context, listen: false).otpcode ?? "";
            verifyOtp(context, userotp);
          },
          child: Container(
            height: size.height * 0.07,
            width: size.width,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 0, 0),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                'Submit',
                style: GoogleFonts.comfortaa(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void verifyOtp(context, String userotp) {
    FirebaseAuthServices service = FirebaseAuthServices();
    service.verifyOtp(
        verificationId: veridicationId,
        otp: userotp,
        onSuccess: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
        });
  }
}
