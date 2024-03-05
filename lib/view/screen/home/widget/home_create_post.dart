import 'package:earning/constant/app_colors.dart';
import 'package:earning/controller/home_controller.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeCreatePost extends StatelessWidget {
  const HomeCreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return GetBuilder<HomeController>(
      builder: (logic) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: GestureDetector(
            onTap: (){
              if(logic.userModel.isVerified??false){
                Get.toNamed(AppRoute.createPostScreen);
              }else{
                Fluttertoast.showToast(msg: "Your account is not verified, please verify account and start earning");
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.gallery,size: 35,),
                      const SizedBox(width: 8.0),
                      Text("Create post by make money...",style: Theme.of(context).textTheme.titleMedium,),
                    ],
                  ),
                  const Row(
                    children: [
                      Icon(Iconsax.gallery),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
