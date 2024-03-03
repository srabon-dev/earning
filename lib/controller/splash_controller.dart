import 'package:earning/core/route/app_route.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashController extends GetxController{

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  ///this function checking user login or not
  void isUserLoginChecking(){
    if(firebaseAuth.currentUser != null){
      Future.delayed(const Duration(seconds: 2),(){
        Get.offAndToNamed(AppRoute.navScreen);
      });
    }else{
      Future.delayed(const Duration(seconds: 2),(){
        Get.offAndToNamed(AppRoute.loginScreen);
      });
    }
  }

  @override
  void onReady() {
    isUserLoginChecking();
    super.onReady();
  }
}