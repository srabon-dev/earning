import 'package:earning/controller/nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavController>(
      init: NavController(),
      builder: (logic) {
        return Scaffold(
          //Body Section
          body: logic.screen[logic.bottomNavIndex],
          //BottomNavigationBar Section
          bottomNavigationBar: NavigationBar(
            selectedIndex: logic.bottomNavIndex,
            onDestinationSelected: logic.navigation,
            animationDuration: const Duration(milliseconds: 400),
            destinations: const [
              NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
              NavigationDestination(icon: Icon(Iconsax.video), label: "My Video"),
              NavigationDestination(icon: Icon(Iconsax.transaction_minus), label: "My Earning"),
              NavigationDestination(icon: Icon(Iconsax.profile_circle), label: "Profile"),
            ],
          ),
        );
      },
    );
  }
}