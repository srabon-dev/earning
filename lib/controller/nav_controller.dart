import 'package:earning/view/screen/home/home_screen.dart';
import 'package:earning/view/screen/video/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavController extends GetxController{
  List<Widget> screen = [
    HomeScreen(),
    MyVideoScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  int bottomNavIndex = 0;
  void navigation(int currentIndex) {
    bottomNavIndex = currentIndex;
    update();
  }

}