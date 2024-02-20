import 'package:ecommerce/controller/home_provider.dart';
import 'package:ecommerce/model/item_model.dart';
import 'package:ecommerce/view/screens/product%20screen/product_details_page.dart';
import 'package:ecommerce/view/widgets/text_widgets.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<HomeProvider>(builder: (context, provider, child) {
            final List<ProductModel> myProducts = filteringMyProduct(provider);
            return myProducts.isNotEmpty
                ? Expanded(
                    child: ListView.separated(
                      itemCount: myProducts.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final product = myProducts[index];
                        return Slidable(
                            startActionPane:
                                ActionPane(motion: ScrollMotion(), children: [
                              SlidableAction(
                                onPressed: (context) async {
                                  await provider.IsWishLIstClick(
                                      product.id, false);
                                },
                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              )
                            ]),
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  flex: 2,
                                  onPressed: (context) {},
                                  backgroundColor: Color(0xFF7BC043),
                                  foregroundColor: Colors.white,
                                  icon: Icons.badge,
                                  label: 'Buy Now',
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: () =>
                                    Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ProductDetailsPage(
                                      products: product,
                                    );
                                  },
                                )),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: size.width * .2,
                                      width: size.width * .2,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  product.image.toString()),
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
                                            text: product.title.toString()),
                                        TextWidgets().subtitleText(context,
                                            text: product.category.toString()),
                                        TextWidgets().titleText2(context,
                                            text:
                                                "₹${product.price.toString()}"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                    ),
                  )
                : Center(
                    child: Lottie.asset(
                        width: size.width * .20,
                        height: size.width * .20,
                        'assets/lottie.json'),
                  );
          }),
        ],
      ),
    );
  }

  List<ProductModel> filteringMyProduct(HomeProvider provider) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return [];
    }
    final user = currentUser.email ?? currentUser.phoneNumber;

    List<ProductModel> myProducts = provider.allProduct
        .where((product) => product.wishList!.contains(user))
        .toList();

    return myProducts;
  }
}
