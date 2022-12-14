import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/features/home/screens/category_detail_screen.dart';
import 'package:amazon_clone/features/home/widgets/deal_of_day.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final TextEditingController _searchController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: (stringQuery) => Navigator.pushNamed(
                            context, SearchScreen.routeName,
                            arguments: stringQuery),
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                left: 6,
                              ),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black38,
                              width: 1,
                            ),
                          ),
                          hintText: 'Search Amazon.in',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(Icons.mic, color: Colors.black, size: 25),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          Container(
            height: 40,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 114, 226, 221),
                  Color.fromARGB(255, 162, 236, 233),
                ],
                stops: [0.5, 1.0],
              ),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_rounded,
                  color: Colors.black,
                  size: 20,
                ),
                Expanded(
                  child: Text(
                    ' Delivery to ${user.name} - ${user.address}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_drop_down,
                    color: Colors.black, size: 20),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 60,
            child: ListView.builder(
              itemCount: GlobalVariables.categoryImages.length,
              scrollDirection: Axis.horizontal,
              itemExtent: 75,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, CategoryDetailScreen.routeName,
                      arguments: GlobalVariables.categoryImages[index]
                          ['title']),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            GlobalVariables.categoryImages[index]['image']!,
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                      Text(
                        GlobalVariables.categoryImages[index]['title']!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          CarouselSlider(
            items: GlobalVariables.carouselImages.map((e) {
              return Builder(
                builder: (context) => Image.network(
                  e,
                  fit: BoxFit.cover,
                  height: 200,
                ),
              );
            }).toList(),
            options: CarouselOptions(viewportFraction: 1, height: 200),
          ),
          const SizedBox(height: 10),
          const Divider(color: Colors.grey),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Deals of the day',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    'See more',
                    style: TextStyle(
                      color: Color.fromARGB(255, 29, 201, 192),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const DealOfDay(),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              for (int i = 0; i < user.cart.length; i++) {
                print(user.cart[i].product.name);
                print(user.cart[i].quantity);
                print('------------------');
              }
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '    See More Deals',
                style: TextStyle(
                  color: GlobalVariables.selectedNavBarColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
