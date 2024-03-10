import 'package:earning/constant/app_colors.dart';
import 'package:earning/constant/app_constants.dart';
import 'package:earning/controller/home_controller.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:earning/view/screen/auth/intro/auth_screen.dart';
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
                      onTap: () async {
                        Get.toNamed(AppRoute.languagesScreen,arguments: false);
                      },
                      child: ListTile(
                        leading: Icon(Iconsax.language_square),
                        title: Text("languages".tr),
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
                        Get.toNamed(AppRoute.privacyPolicy);
                      },
                      child: ListTile(
                        leading: Icon(Icons.privacy_tip_outlined),
                        title: Text("privacy_policy".tr),
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
                      child: ListTile(
                        leading: Icon(Iconsax.info_circle),
                        title: Text("terms_of_ues".tr),
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
                      child: ListTile(
                        leading: Icon(Iconsax.information),
                        title: Text("about_us".tr),
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
                        await FirebaseAuth.instance.signOut().then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AuthScreen()),(route) => false));
                      },
                      child: ListTile(
                        leading: Icon(Iconsax.logout),
                        title: Text("logout".tr),
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