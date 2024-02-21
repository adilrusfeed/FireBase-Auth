// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
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
    'assets/offer0.jpg',
    'assets/offerdiwali.jpg',
    'assets/offer20.png'
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
    'https://w0.peakpx.com/wallpaper/110/397/HD-wallpaper-xiaomi-android-mobile-phone-2019.jpg',
    'https://img.lovepik.com/element/45012/8521.png_860.png',
    'https://5.imimg.com/data5/SELLER/Default/2020/11/CS/FW/VL/15119067/41crkwnji4l.jpg',
    'https://img.freepik.com/free-photo/pink-headphones-wireless-digital-device_53876-96804.jpg',
    'https://t3.ftcdn.net/jpg/00/52/45/32/360_F_52453293_qGCRFdf6nEkCLjBuRIHQIQMOOaYmgNpN.jpg',
    'https://www.pngitem.com/pimgs/b/23-230878_accessories-for-the-computer-have-them-now-best.png',
    'https://m.media-amazon.com/images/I/61CorIpO46S._AC_UF1000,1000_QL80_.jpg'
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
                CarouselSlider(
                  options: CarouselOptions(
                    height: size.width * 0.4,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: specialProduct.map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }).toList(),
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
