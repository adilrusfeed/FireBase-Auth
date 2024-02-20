import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? user;
  String? id;
  String? title;
  String? brand;
  String? description;
  String? category;
  List<String>? wishList;
  List<String>? cart;
  DateTime? timeStamp;
  String? image;
  int? price;
  ProductModel(
      {this.cart,
      this.category,
      this.user,
      this.id,
      this.image,
      this.price,
      this.description,
      this.brand,
      this.timeStamp,
      this.title,
      this.wishList});
  factory ProductModel.fromJson(String id, Map<String, dynamic> json) {
    return ProductModel(
      user: json['user'],
      id: id,
      timeStamp: json['timeStamp'] != null
          ? (json['timeStamp'] as Timestamp).toDate()
          : null,
      cart: List<String>.from(json["cart"] ?? []),
      category: json['category'],
      image: json['image'],
      price: json['price'],
      brand: json['brand'],
      description: json['description'],
      title: json['title'],
      wishList: List<String>.from(json["wishList"] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cart': cart,
      'category': category,
      'user': user,
      'image': image,
      'price': price,
      'brand': brand,
      'description': description,
      'timeStamp': timeStamp,
      'title': title,
      'wishList': wishList,
    };
  }
}
