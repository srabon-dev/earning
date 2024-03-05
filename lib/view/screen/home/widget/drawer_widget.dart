import 'dart:developer';

import 'package:earning/constant/app_colors.dart';
import 'package:earning/constant/app_constants.dart';
import 'package:earning/constant/app_images.dart';
import 'package:earning/controller/home_controller.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GetBuilder<HomeController>(builder: (logic) {
        return SingleChildScrollView(
          child: Column(
            children: [

              //Drawer Header Section
              DrawerHeader(
                child: SizedBox(
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(AppConstants.appName,style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 34
                      ),),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),

              //Drawer Item List Section
              Column(
                children: [
                  /*Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: AppColors.whiteColor),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoute.favoriteScreen);
                      },
                      child: ListTile(
                        leading: Icon(Iconsax.lovely5),
                        title: Text("Favorite"),
                        trailing: const Icon(Iconsax.arrow_right),
                      ),
                    ),
                  ),*/
                  Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: AppColors.whiteColor),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoute.privacyPolicy);
                      },
                      child: const ListTile(
                        leading: Icon(Icons.privacy_tip_outlined),
                        title: Text("Privacy Policy"),
                        trailing: Icon(Iconsax.arrow_right),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: AppColors.whiteColor),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoute.termsOfService);
                      },
                      child: const ListTile(
                        leading: Icon(Iconsax.info_circle),
                        title: Text("Terms of Service"),
                        trailing: Icon(Iconsax.arrow_right),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: AppColors.whiteColor),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoute.aboutUs);
                      },
                      child: const ListTile(
                        leading: Icon(Iconsax.information),
                        title: Text("About us"),
                        trailing: Icon(Iconsax.arrow_right),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: AppColors.whiteColor),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoute.contactUs);
                      },
                      child: const ListTile(
                        leading: Icon(Iconsax.info_circle),
                        title: Text("Contact Us"),
                        trailing: Icon(Iconsax.arrow_right),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: AppColors.whiteColor),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut().then((value){
                          Get.offAndToNamed(AppRoute.loginScreen);
                        }).onError((error, stackTrace){
                          log(error.toString());
                        });
                      },
                      child: const ListTile(
                        leading: Icon(Iconsax.logout),
                        title: Text("Logout"),
                        trailing: Icon(Iconsax.arrow_right),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}