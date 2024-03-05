import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earning/model/user_model.dart';
import 'package:earning/view/screen/earning/earning_screen.dart';
import 'package:earning/view/screen/home/home_screen.dart';
import 'package:earning/view/screen/post/my_post_screen.dart';
import 'package:earning/view/screen/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserModel userModel = UserModel();

  bool isLoading = false;
  Future<void> getUserDetails() async {
    isLoading = true;
    update();
    try {
      await firestore.collection('user').doc(firebaseAuth.currentUser?.uid).get().then((value) async {
        userModel = UserModel.fromJson(value.data() ?? {});
        isLoading = false;
        update();
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(msg: error.toString());
        isLoading = false;
        update();
      }).timeout(const Duration(seconds: 10));
    } catch (error) {
      isLoading = false;
      update();
      Fluttertoast.showToast(msg: error.toString());
    }
  }


  @override
  void onInit() {
    getUserDetails();
    super.onInit();
  }
}