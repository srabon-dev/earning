import 'package:earning/constant/app_images.dart';
import 'package:earning/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (logic){
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: Image.asset(AppImages.logo),
            ),
          ),
        );
      },
    );
  }
}
