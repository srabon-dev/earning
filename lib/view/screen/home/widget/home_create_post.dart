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
        return GestureDetector(
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
                color: isDarkMode ? AppColors.whiteColor.withOpacity(0.4) : AppColors.blackColor.withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Iconsax.gallery,size: 35,),
                const SizedBox(width: 12.0),
                Text("Create posts and making money...",style: Theme.of(context).textTheme.titleMedium,),
              ],
            ),
          ),
        );
      }
    );
  }
}
