import 'package:earning/constant/app_colors.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeCreatePost extends StatelessWidget {
  const HomeCreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
      child: GestureDetector(
        onTap: (){
          Get.toNamed(AppRoute.createPostScreen);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
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
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(Iconsax.add),
                  ),
                  const SizedBox(width: 8.0),
                  const Text("Create post by make money..."),
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
}
