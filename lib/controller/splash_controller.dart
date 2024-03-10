import 'package:earning/constant/app_constants.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  ///this function checking user login or not
  void isUserLoginChecking() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      if(sharedPreferences.getString(AppConstants.languageCode) != null && sharedPreferences.getString(AppConstants.languageCode) != ""){
        if (firebaseAuth.currentUser != null) {
          Future.delayed(const Duration(seconds: 1), () {
            Get.offAllNamed(AppRoute.navScreen);
          });
        } else {
          Future.delayed(const Duration(seconds: 1), () {
            Get.offAllNamed(AppRoute.authIntroScreen);
          });
        }
      }else{
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAllNamed(AppRoute.languagesScreen,arguments: true);
        });
      }
  }

  @override
  void onReady() {
    isUserLoginChecking();
    super.onReady();
  }
}
