import 'package:earning/constant/app_images.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:earning/view/widget/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 12),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/8,
            child: Column(
              children: [
                CustomButton(
                    text: "login".tr,
                    onTap: () {
                      Get.toNamed(AppRoute.loginScreen);
                    }),
                const SizedBox(height: 12,),
                CustomButton(
                    text: "create_account".tr,
                    onTap: () {
                      Get.toNamed(AppRoute.registerScreen);
                    }),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(AppImages.auth,fit: BoxFit.cover,),
              ),

              Text("earn_money_from_home".tr,style: Theme.of(context).textTheme.titleLarge,textAlign: TextAlign.center,),
              Text("earn_real_money_by_completing_simple_tasks".tr,style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
    );
  }
}
