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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () async {
                      await ProductWidgets()
                          .showImagePickerBottomSheet(context, imageProvider);
                    },
                    child: Row(
                      children: [
                        Consumer<imageProviders>(
                            builder: (context, value, child) {
                          return Container(
                            width: size.width * .3,
                            height: size.width * .3,
                            decoration: BoxDecoration(
                              boxShadow: const [],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  scale: size.width * .07,
                                  image: value.file == null
                                      ? AssetImage(
                                          'assets/image.jpg',
                                        )
                                      : FileImage(
                                          File(value.file!.path),
                                        ) as ImageProvider),
                              borderRadius: BorderRadius.circular(15),
                              // color: Color.fromARGB(255, 255, 255, 255)
                            ),
                          );
                        }),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFieldWidgets().textFormField(size,
                                    label: "Title",
                                    controller: getProvider.titleController),
                                TextFieldWidgets().textFormField(size,
                                    label: "Brand",
                                    controller: getProvider.subtitleController),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * .01),
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
                        // maxLines: 2,
                        controller: getProvider.descriptionController,
                      ),
                      TextFieldWidgets().textFormField(size,
                          label: "Price",
                          prefixText: '₹',
                          keyboardType: TextInputType.number,
                          inputFormatter:
                              FilteringTextInputFormatter.digitsOnly,
                          controller: getProvider.priceController),
                      SizedBox(height: size.width * 0.05),
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
