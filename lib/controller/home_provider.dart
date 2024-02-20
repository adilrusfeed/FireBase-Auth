import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/item_model.dart';
import 'package:ecommerce/service/sevice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String currentusername = '';
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final DatabaseService databaseService = DatabaseService();
  // final WidgetProviders widgetProviders = WidgetProviders();
  List<ProductModel> allProduct = [];
  String downloadURL = '';
  String imageName = DateTime.now().millisecondsSinceEpoch.toString();

  getCurrentUser() async {
    final currentuser = FirebaseAuth.instance.currentUser;
    if (currentuser != null) {
      try {
        var user =
            await firestore.collection("users").doc(currentuser.uid).get();
        if (user.data()?['name'] != null) {
          currentusername = user.data()!['name'];
          notifyListeners();
        } else {
          currentusername = '';
          notifyListeners();
        }
      } catch (e) {
        throw Exception(e);
      }
    }
  }

  List<String> cartList = [];
  setIsInCart(String productId, bool isInCart) {
    if (isInCart) {
      cartList.add(productId); // Add product to cart
    } else {
      cartList.remove(productId); // Remove product from cart
    }
    notifyListeners();
  }

  addToCart(String productId) {
    if (!cartList.contains(productId)) {
      cartList.add(productId); // Add product to cart
    }
    notifyListeners();
  }

  removeFromCart(String productId) {
    cartList.remove(productId); // Remove product from cart
    notifyListeners();
  }

  addProduct(ProductModel data) async {
    await databaseService.addProduct(data);
    clearControllers();
    getAllProducts();
  }

  IsWishLIstClick(id, bool wishListStatus) async {
    await databaseService.IsWishListClick(id, wishListStatus);
    notifyListeners();
    getAllProducts();
  }

  Future<void> getAllProducts() async {
    allProduct = await databaseService.getAllProducts();
    notifyListeners();
  }

  Future<void> deleteMyProduct(productId) async {
    await databaseService.deleteMyProduct(productId);
    notifyListeners();
    getAllProducts();
  }

  List<ProductModel> searchedList = [];
  searchFilter(String value) {
    searchedList = allProduct
        .where((product) =>
            product.title!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }

  uploadImage(image) async {
    try {
      if (image != null) {
        downloadURL = await databaseService.uploadImage(imageName, image);

        notifyListeners();
      } else {
        log('image is null');
      }
    } catch (e) {
      log("$e");
      throw e;
    }
  }

  clearControllers() {
    titleController.clear();
    subtitleController.clear();
    priceController.clear();
    descriptionController.clear();
    notifyListeners();
  }
}
