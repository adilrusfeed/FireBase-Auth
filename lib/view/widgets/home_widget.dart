import 'package:ecommerce/controller/home_provider.dart';
import 'package:ecommerce/model/item_model.dart';
import 'package:ecommerce/view/screens/category_page.dart';
import 'package:ecommerce/view/screens/product%20screen/product_details_page.dart';
import 'package:ecommerce/view/widgets/icon_widget.dart';
import 'package:ecommerce/view/widgets/text_widgets.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeWidgets {
  Widget specialProduct(Size size, {required String imagePath}) {
    return Container(
      width: size.width * .7,
      height: size.width * .4,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
        color: const Color.fromARGB(255, 30, 29, 29),
        borderRadius: BorderRadius.all(Radius.circular(size.width * .03)),
      ),
    );
  }

  Widget categoryItems(context, Size size,
      {category, required String imagePath}) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return CategoryPage(
            category: category,
          );
        },
      )),
      child: Container(
        width: size.width * .2,
        height: size.width * .2,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(imagePath), fit: BoxFit.cover),
          // color: const Color.fromARGB(0, 255, 0, 0),
          borderRadius: BorderRadius.all(Radius.circular(size.width * .05)),
        ),
      ),
    );
  }

  Widget buildProductItem(Size size, HomeProvider provider,
      {List<ProductModel>? products}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: size.width * 0.05,
        crossAxisSpacing: size.width * 0.015,
        childAspectRatio: size.width / (size.width * 1.5),
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ProductDetailsPage(
                    products: product,
                  );
                },
              )),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.width * 0.42,
                      width: size.width * 0.42,
                      child: product.image!.isNotEmpty
                          ? Image(
                              fit: BoxFit.contain,
                              image: NetworkImage(product.image!),
                            )
                          : Lottie.asset('assets/lottie.json'),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: size.width * .1,
                      child: TextWidgets()
                          .titleText2(context, text: product.title!),
                    ),
                    TextWidgets().subtitleText(context, text: product.brand!),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidgets().titleText2(context,
                            text: "₹${product.price.toString()}"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              right: 2,
              bottom: 2,
              child: IconsWidgets().IconButtonWidget(
                context,
                size,
                iconData: wishListCheck(product)
                    ? Icons.heart_broken
                    : Icons.heart_broken,
                color: Colors.red,
                onPressed: () async {
                  final value = await wishListCheck(product);
                  provider.isWishLIstClick(product.id, value);
                },
              ),
            ),
          ],
        );
      },
      itemCount: products!.length,
    );
  }

  bool wishListCheck(ProductModel product) {
    final user = FirebaseAuth.instance.currentUser;
    final userEmail = user!.email ?? user.phoneNumber;
    if (product.wishList!.contains(userEmail)) {
      return false;
    } else {
      return true;
    }
  }
}
