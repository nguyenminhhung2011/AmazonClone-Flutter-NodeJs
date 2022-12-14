import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/cart/screens/cart_screen.dart';
import 'package:flutter/material.dart';

import '../../constants/global_variables.dart';
import '../../features/home/screens/home_screen.dart';
import '../../providers/user_provider.dart';
import 'package:badges/badges.dart';

import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidh = 42;
  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];
  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomBarWidh,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: 5,
                  ),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomBarWidh,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: 5,
                  ),
                ),
              ),
              child: const Icon(Icons.person),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomBarWidh,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: 5,
                  ),
                ),
              ),
              child: Badge(
                elevation: 1,
                badgeContent: Text(
                  userCartLen.toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                badgeColor: Colors.red,
                child: const Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
