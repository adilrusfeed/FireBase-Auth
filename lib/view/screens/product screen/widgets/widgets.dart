import 'package:ecommerce/controller/image_provider.dart';
import 'package:ecommerce/view/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductWidgets {
  showImagePickerBottomSheet(context, imageProviders value) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 250,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.camera,
                    size: 60,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await value.pickImage(ImageSource.camera);
                      },
                      child: TextWidgets().BodyText(context,
                          text: 'Camera', color: Color.fromARGB(255, 0, 0, 0)))
                ],
              ),
              Column(
                children: [
                  const Icon(
                    Icons.photo,
                    size: 60,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await value.pickImage(ImageSource.gallery);
                      },
                      child: TextWidgets().BodyText(context,
                          text: 'Gallery',
                          color: const Color.fromARGB(255, 0, 0, 0)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
