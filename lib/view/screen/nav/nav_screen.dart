import 'package:earning/view/screen/earning/earning_screen.dart';
import 'package:earning/view/screen/home/home_screen.dart';
import 'package:earning/view/screen/post/my_post_screen.dart';
import 'package:earning/view/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
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
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
          NavigationDestination(icon: Icon(Iconsax.video), label: "Post"),
          NavigationDestination(icon: Icon(Iconsax.coin), label: "Coin"),
          NavigationDestination(icon: Icon(Iconsax.profile_circle), label: "Profile"),
        ],
      ),
    );
  }
}