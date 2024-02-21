import 'package:ecommerce/controller/home_provider.dart';
import 'package:ecommerce/model/item_model.dart';
import 'package:ecommerce/view/screens/product%20screen/sell_product.dart';
import 'package:ecommerce/view/widgets/appbar_widget.dart';
import 'package:ecommerce/view/widgets/button_widget.dart';
import 'package:ecommerce/view/widgets/icon_widget.dart';
import 'package:ecommerce/view/widgets/text_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MyProductPage extends StatelessWidget {
  const MyProductPage({Key? key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarWidgets().appBar(
        title: 'My Products',
        context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<HomeProvider>(
                  builder: (context, provider, _) {
                    final List<ProductModel> myProducts =
                        filteringMyProduct(provider);
                    return myProducts.isNotEmpty
                        ? Expanded(
                            child: ListView.separated(
                              itemCount: myProducts.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemBuilder: (context, index) {
                                final product = myProducts[index];
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: size.width * .2,
                                            width: size.width * .2,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(product
                                                        .image
                                                        .toString()),
                                                    fit: BoxFit.cover),
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                          ),
                                          SizedBox(
                                            width: size.width * .02,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextWidgets().titleText2(context,
                                                  text:
                                                      product.title.toString()),
                                              TextWidgets().subtitleText(
                                                  context,
                                                  text: product.category
                                                      .toString()),
                                              Row(
                                                children: [
                                                  TextWidgets().titleText2(
                                                      context,
                                                      text: product.price
                                                          .toString()),
                                                  SizedBox(
                                                    width: size.width * .04,
                                                  ),
                                                  TextWidgets().subtitleText(
                                                      context,
                                                      text: '/Sold',
                                                      color: Colors.green),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      IconsWidgets().IconButtonWidget(
                                          context, size, onPressed: () async {
                                        await provider
                                            .deleteMyProduct(product.id);
                                      }, iconData: Icons.delete),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : Column(
                            children: [
                              Center(
                                child: Lottie.asset(
                                    width: size.width * .20,
                                    height: size.width * .20,
                                    'assets/lottie.json'),
                              ),
                              const Text("add products ")
                            ],
                          );
                  },
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.transparent,
                child: ButtonWidgets().fullWidthElevatedButton(
                  size,
                  label: 'Add Product',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) {
                          return SellProductPage();
                        }),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  filteringMyProduct(HomeProvider provider) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return null;
    }

    final user = currentUser.email ?? currentUser.phoneNumber;

    List<ProductModel> myProducts =
        provider.allProduct.where((product) => product.user == user).toList();
    return myProducts;
  }
}
