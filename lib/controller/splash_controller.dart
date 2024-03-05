import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:earning/model/user_model.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashController extends GetxController{

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserModel userModel = UserModel();

  ///this function checking user login or not
  void isUserLoginChecking() async{
    if(firebaseAuth.currentUser != null){
      Future.delayed(const Duration(seconds: 1),(){
        if((userModel.email??"") == (firebaseAuth.currentUser?.email??"")){
          Get.offAndToNamed(AppRoute.navScreen);
        }else{
          Get.offAndToNamed(AppRoute.loginScreen);
        }
      });
    }else{
      Future.delayed(const Duration(seconds: 2),(){
        Get.offAndToNamed(AppRoute.loginScreen);
      });
    }
  }

  Future<void> getUserDetails() async {
    try {
      await firestore.collection('user').doc(firebaseAuth.currentUser?.uid).get().then((value) async {
        userModel = UserModel.fromJson(value.data() ?? {});
        update();
      }).onError((error, stackTrace) {
        log(error.toString());
      }).timeout(const Duration(seconds: 10));
    } catch (error) {
      log(error.toString());
    }
  }


  @override
  void onReady() {
    getUserDetails();
    isUserLoginChecking();
    super.onReady();
  }
}