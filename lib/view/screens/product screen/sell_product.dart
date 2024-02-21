import 'dart:io';
import 'package:ecommerce/controller/home_provider.dart';
import 'package:ecommerce/controller/image_provider.dart';

import 'package:ecommerce/model/item_model.dart';
import 'package:ecommerce/view/screens/product%20screen/widgets/widgets.dart';
import 'package:ecommerce/view/widgets/appbar_widget.dart';
import 'package:ecommerce/view/widgets/button_widget.dart';
import 'package:ecommerce/view/widgets/popup_widget.dart';
import 'package:ecommerce/view/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SellProductPage extends StatelessWidget {
  SellProductPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final List<String> categories = [
    'Mobile',
    'Laptop',
    'Smartwatch',
    'Headphones',
    'Camera',
    'Mouse and Keyboard',
    'Speaker',
  ];

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final getProvider = Provider.of<HomeProvider>(context, listen: false);
    final imageProvider = Provider.of<imageProviders>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidgets().appBar(
        context,
        title: 'Sell Product',
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    await ProductWidgets()
                        .showImagePickerBottomSheet(context, imageProvider);
                  },
                  child: Container(
                    width: size.width * .4,
                    height: size.width * .4,
                    decoration: BoxDecoration(
                      boxShadow: const [],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        scale: size.width * .05,
                        image: imageProvider.file == null
                            ? AssetImage('assets/image.jpg')
                            : FileImage(
                                File(imageProvider.file!.path),
                              ) as ImageProvider,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFieldWidgets().textFormField(
                  size,
                  label: "Title",
                  controller: getProvider.titleController,
                ),
                TextFieldWidgets().textFormField(
                  size,
                  label: "Brand",
                  controller: getProvider.subtitleController,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .01),
                  child: DropdownButtonFormField<String>(
                    value: selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'Category',
                    ),
                    onChanged: (value) {
                      selectedCategory = value;
                    },
                    items: categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select category';
                      }
                      return null;
                    },
                  ),
                ),
                TextFieldWidgets().textFormField(
                  size,
                  label: "Description",
                  controller: getProvider.descriptionController,
                ),
                TextFieldWidgets().textFormField(
                  size,
                  label: "Price",
                  prefixText: '₹',
                  keyboardType: TextInputType.number,
                  inputFormatter: FilteringTextInputFormatter.digitsOnly,
                  controller: getProvider.priceController,
                ),
                SizedBox(height: 20),
                ButtonWidgets().fullWidthElevatedButton(
                  size,
                  label: 'Sell Product',
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (imageProvider.file != null) {
                        await addProduct(context);
                        Navigator.pop(context);
                      } else {
                        PopupWidgets().showErrorSnackbar(
                            context, 'Please Select a image');
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addProduct(context) async {
    final getProvider = Provider.of<HomeProvider>(context, listen: false);
    final getimageProvider =
        Provider.of<imageProviders>(context, listen: false);
    PopupWidgets().showLoadingIndicator(context);
    await getProvider.uploadImage(File(getimageProvider.file!.path));

    final user = FirebaseAuth.instance.currentUser;
    final product = ProductModel(
      user: user!.email ?? user.phoneNumber,
      title: getProvider.titleController.text,
      brand: getProvider.subtitleController.text,
      description: getProvider.descriptionController.text,
      price: int.parse(getProvider.priceController.text),
      image: getProvider.downloadURL,
      wishList: [],
      category: selectedCategory,
      timeStamp: DateTime.now(),
    );
    getProvider.addProduct(product);
    getimageProvider.file = null;
    Navigator.pop(context);
  }
}
