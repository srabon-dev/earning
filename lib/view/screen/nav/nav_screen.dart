import 'package:earning/view/screen/earning/earning_screen.dart';
import 'package:earning/view/screen/home/home_screen.dart';
import 'package:earning/view/screen/post/my_post_screen.dart';
import 'package:earning/view/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  List<Widget> screen = [
    const HomeScreen(),
    const MyPostScreen(),
    const EarningScreen(),
    const ProfileScreen(),
  ];
  int bottomNavIndex = 0;
  void navigation(int currentIndex) {
    bottomNavIndex = currentIndex;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //Body Section
      body: screen[bottomNavIndex],

      //BottomNavigationBar Section
      bottomNavigationBar: NavigationBar(
        selectedIndex: bottomNavIndex,
        onDestinationSelected: navigation,
        animationDuration: const Duration(milliseconds: 400),
        destinations: [
          NavigationDestination(icon: const Icon(Iconsax.home), label: "home".tr),
          NavigationDestination(icon: const Icon(Iconsax.video), label: "post".tr),
          NavigationDestination(icon: const Icon(Iconsax.coin), label: "coin".tr),
          NavigationDestination(icon: const Icon(Iconsax.profile_circle), label: "profile".tr),
        ],
      ),
    );
  }
}