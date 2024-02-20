// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/controller/home_provider.dart';
import 'package:ecommerce/view/screens/wishlist_screen.dart';
import 'package:ecommerce/view/widgets/home_widget.dart';
import 'package:ecommerce/view/widgets/settings/drawer_page.dart';
import 'package:ecommerce/view/widgets/text_widgets.dart';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).getAllProducts();
  }

  final List<String> specialProduct = [
    'assets/offer 1.jpg',
    'assets/offer 2.jpg',
    'assets/offer 3.jpg'
  ];

  final List<String> catorgoryName = [
    'Mobile',
    'Laptop',
    'Smartwatch',
    'Headphones',
    'Camera',
    'Mouse and Keyboard',
    'Speaker',
  ];
  final List<String> catorgoryItems = [
    'https://m.media-amazon.com/images/G/31/img23/CEPC/BAU/ELP/navtiles/Tablets._CB574550011_.png',
    'https://m.media-amazon.com/images/G/31/img23/CEPC/BAU/ELP/navtiles/Gaming-laptops._CB574550011_.png',
    'https://m.media-amazon.com/images/G/31/img23/CEPC/BAU/ELP/navtiles/Wearables._CB574550011_.png',
    'https://m.media-amazon.com/images/G/31/img23/CEPC/BAU/ELP/navtiles/Headphones._CB574550011_.png',
    'https://m.media-amazon.com/images/G/31/img23/CEPC/BAU/ELP/navtiles/Cameras._CB574550011_.png',
    'https://m.media-amazon.com/images/G/31/img23/CEPC/BAU/ELP/navtiles/Computer-Accessories._CB574550011_.png',
    'https://m.media-amazon.com/images/G/31/img23/CEPC/BAU/ELP/navtiles/Soundbars._CB574550011_.png'
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final getAuthPrv = Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.width * .2,

        title: SizedBox(
          width: size.width * .6,
          child: TextFormField(
            onChanged: (value) {
              getAuthPrv.searchFilter(value);
            },
            decoration: InputDecoration(
              hintText: "Search",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.heart_broken),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return WishlistPage();
                },
              ));
            },
          ),
        ],
        // backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        elevation: 100,
        shadowColor: const Color.fromARGB(255, 227, 227, 226),
        child: Container(
          color: Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "settings",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Expanded(child: DrawerHeaderWidget()),
            ],
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidgets().mainHeadingText(context, text: 'Category  '),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      catorgoryItems.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(
                          right: 8,
                        ),
                        child: HomeWidgets().categoryItems(context, size,
                            category: catorgoryName[index],
                            imagePath: catorgoryItems[index]),
                      ),
                    ),
                  ),
                ),
                TextWidgets().mainHeadingText(context, text: 'Sponsered  '),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      specialProduct.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(
                          right: 8,
                        ),
                        child: HomeWidgets().specialProduct(
                          size,
                          imagePath: specialProduct[index],
                        ),
                      ),
                    ),
                  ),
                ),
                TextWidgets().mainHeadingText(context, text: 'Products  '),
                Consumer<HomeProvider>(builder: (context, provider, child) {
                  return provider.allProduct.isNotEmpty
                      ? HomeWidgets().buildProductItem(
                          size,
                          provider,
                          products: provider.searchedList.isEmpty
                              ? provider.allProduct
                              : provider.searchedList,
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: size.width * .2,
                            ),
                            Center(
                              child: Lottie.asset(
                                  width: size.width * .20,
                                  height: size.width * .20,
                                  'assets/lottie.json'),
                            ),
                          ],
                        );
                })
              ],
            ),
          )),
    );
  }
}
