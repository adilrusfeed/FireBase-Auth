import 'package:flutter/material.dart';

class CustomPhoneField extends StatelessWidget {
  const CustomPhoneField(
      {super.key, required this.controller, required this.hinttext});

  final TextEditingController controller;
  final String hinttext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: controller,
        decoration: InputDecoration(
          prefixText: '+91 ',
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30)),
          hintText: hinttext,
          hintStyle: const TextStyle(),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hinttext,
      required this.fillcolor});

  final TextEditingController controller;
  final String hinttext;
  final Color fillcolor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: fillcolor,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30)),
          hintText: hinttext,
          hintStyle: const TextStyle()),
    );
  }
}
