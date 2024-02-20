import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/controller/home_provider.dart';
import 'package:ecommerce/model/item_model.dart';
import 'package:ecommerce/view/screens/product%20screen/product_details_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          final List<ProductModel> cartProducts =
              filteringCartProducts(provider);
          return cartProducts.isNotEmpty
              ? ListView.separated(
                  itemCount: cartProducts.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final product = cartProducts[index];
                    return ListTile(
                      leading: Container(
                        height: size.width * .2,
                        width: size.width * .2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(product.image.toString()),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      title: Text(product.title.toString()),
                      subtitle: Text("₹${product.price.toString()}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await provider.removeFromCart(product.id!);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              products: product,
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              : const Center(
                  child: Text('Your cart is empty.'),
                );
        },
      ),
    );
  }

  List<ProductModel> filteringCartProducts(HomeProvider provider) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return [];
    }
    final user = currentUser.email ?? currentUser.phoneNumber;

    List<ProductModel> cartProducts = provider.allProduct
        .where((product) => provider.cartList.contains(product.id))
        .toList();

    return cartProducts;
  }
}
