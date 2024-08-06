import 'package:flutter/material.dart';
import 'package:flutter_application_/screens/cart/cart_screens.dart';
import 'package:flutter_application_/screens/home_pages.dart';
import 'package:flutter_application_/screens/profile_screens.dart';
import 'package:flutter_application_/screens/search_screns.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class RootScreens extends StatefulWidget {
  static const routeName = "/RootScreens";
  const RootScreens({super.key});

  @override
  State<RootScreens> createState() => _RootScreensState();
}

class _RootScreensState extends State<RootScreens> {
  late PageController controller;
  int currentScreens = 0;
  List<Widget> screens = [
    const HomePages(),
    const SearchScreens(),
    const CartScreens(),
    const ProfileScreens(),
  ];
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentScreens);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreens,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        height: kBottomNavigationBarHeight,
        elevation: 2,
        onDestinationSelected: (value) {
          setState(() {
            currentScreens = value;
          });
          controller.jumpToPage(currentScreens);
        },
        destinations: [
          NavigationDestination(
              selectedIcon: Icon(IconlyLight.home),
              icon: Icon(IconlyLight.home),
              label: "Home"),
          NavigationDestination(
              selectedIcon: Icon(IconlyLight.search),
              icon: Icon(IconlyLight.search),
              label: "Search"),
          NavigationDestination(
              selectedIcon: Icon(IconlyLight.bag2),
              icon: Icon(IconlyLight.bag2),
              label: "Cart"),
          NavigationDestination(
              selectedIcon: Icon(IconlyLight.profile),
              icon: Icon(IconlyLight.profile),
              label: "Profile"),
        ],
      ),
    );
  }
}
