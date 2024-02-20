import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidgets {
  Widget textFormField(
    Size size, {
    String? type,
    TextEditingController? controller,
    TextEditingController? cnfController,
    String? label,
    String? prefixText,
    // int? maxLines,
    TextInputFormatter? inputFormatter,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 08),
      child: TextFormField(
        inputFormatters: inputFormatter != null ? [inputFormatter] : [],
        keyboardType: keyboardType ?? TextInputType.text,

        controller: controller,
        // maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixText: prefixText,
          labelStyle: GoogleFonts.montserrat(color: Colors.black),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
