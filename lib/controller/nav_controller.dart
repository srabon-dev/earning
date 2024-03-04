import 'package:earning/view/screen/earning/earning_screen.dart';
import 'package:earning/view/screen/home/home_screen.dart';
import 'package:earning/view/screen/post/my_post_screen.dart';
import 'package:earning/view/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavController extends GetxController{
  List<Widget> screen = [
    const HomeScreen(),
    const MyPostScreen(),
    const EarningScreen(),
    const ProfileScreen(),
  ];

  int bottomNavIndex = 0;
  void navigation(int currentIndex) {
    bottomNavIndex = currentIndex;
    update();
  }

}