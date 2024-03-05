import 'package:cached_network_image/cached_network_image.dart';
import 'package:earning/constant/app_colors.dart';
import 'package:earning/constant/app_images.dart';
import 'package:earning/controller/profile_controller.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:earning/view/widget/button/custom_button.dart';
import 'package:earning/view/widget/loading/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SafeArea(
      child: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (logic) {
          return Scaffold(
            body: logic.isLoading? const Center(child: CircularProgressIndicator()):
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 44,),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(75),
                      color: isDarkMode?AppColors.whiteColor.withOpacity(0.3) : AppColors.blackColor.withOpacity(0.2),
                    ),
                    child: logic.userModel.image != null && logic.userModel.image != ""? ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CustomLoading(width: 150, height: 150),
                        errorWidget: (context, url, error) =>
                        const Icon(Iconsax.profile_circle,size: 35,),
                        imageUrl: logic.userModel.image!,
                      ),
                    ): Image.asset(AppImages.profile,fit: BoxFit.cover,),
                  ),
                  logic.userModel.isVerified??false? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Account verified",style: Theme.of(context).textTheme.titleLarge,),
                      const Icon(Icons.verified,color: AppColors.greenColor,size: 18,),
                    ],
                  ):Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Account not verified",style: Theme.of(context).textTheme.titleLarge,),
                      const Icon(Icons.cancel_outlined,color: AppColors.redColor,size: 18,),
                    ],
                  ),
                  logic.userModel.isVerified??false?const Text("Post EveryDay And Earning Money!"):const Text("Verify your account and start earning!"),
                  const SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Name",style: Theme.of(context).textTheme.titleLarge,),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 12),
                    width: width,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border.all(color: isDarkMode? AppColors.whiteColor: AppColors.blackColor),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        const Icon(Iconsax.profile_circle),
                        const SizedBox(width: 8.0),
                        Text(logic.userModel.name??""),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Email",style: Theme.of(context).textTheme.titleLarge,),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 12),
                    width: width,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border.all(color: isDarkMode? AppColors.whiteColor: AppColors.blackColor),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.email_outlined),
                        const SizedBox(width: 8.0),
                        Text(logic.userModel.email??""),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Phone",style: Theme.of(context).textTheme.titleLarge,),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 12),
                    width: width,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border.all(color: isDarkMode? AppColors.whiteColor: AppColors.blackColor),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        const Icon(Iconsax.call),
                        const SizedBox(width: 8.0,),
                        Text(logic.userModel.phone??''),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24,),
                  CustomButton(text: "Edit", onTap: (){
                    Get.toNamed(AppRoute.editProfileScreen);
                  }),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
