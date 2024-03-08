import 'package:earning/constant/app_images.dart';
import 'package:earning/controller/languages_controller.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:earning/view/widget/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<LanguagesController>(
        init: LanguagesController(),
        builder: (logic) {
          return Scaffold(
            appBar: CustomAppBar(name: "Languages",isBack: true,onTap: (){
              Get.offAllNamed(AppRoute.navScreen);
            },),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 18,vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Logo Section ------------------------
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: Image.asset(AppImages.logo),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
