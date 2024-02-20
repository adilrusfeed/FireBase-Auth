import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class imageProviders extends ChangeNotifier {
  ImagePicker _imagePicker = ImagePicker();
  File? file;

  pickImage(ImageSource source) async {
    final img = await _imagePicker.pickImage(source: source);
    file = img != null ? File(img.path) : null;
    notifyListeners();
  }
}
