import 'package:cached_network_image/cached_network_image.dart';
import 'package:earning/constant/app_colors.dart';
import 'package:earning/controller/profile_controller.dart';
import 'package:earning/view/widget/app_bar/custom_app_bar.dart';
import 'package:earning/view/widget/button/custom_button.dart';
import 'package:earning/view/widget/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SafeArea(
      child: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (logic) {
          return Scaffold(
            appBar: CustomAppBar(name: "edit_profile".tr,isBack: true),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    logic.imagePhotoFile != null?GestureDetector(
                      onTap: (){
                        logic.showCameraPickDialog(context);
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75),
                          color: isDarkMode?AppColors.whiteColor.withOpacity(0.3) : AppColors.blackColor.withOpacity(0.2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(75),
                          child: Image.file(logic.imagePhotoFile!,fit: BoxFit.cover,),
                        ),
                      ),
                    ):GestureDetector(
                      onTap: (){
                        logic.showCameraPickDialog(context);
                      },
                      child: Container(
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
                            const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error)),
                            imageUrl: logic.userModel.image!,
                          ),
                        ):const Center(child: Icon(Iconsax.gallery_add,size: 35),),
                      ),
                    ),
                    const SizedBox(height: 24),

                    //Name TextField -----------------------------
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "name".tr,
                          style: Theme.of(context).textTheme.titleLarge,
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      hintText: "enter_name".tr,
                      validator: (name) {
                        if (logic.nameController.text == "") {
                          return "please_enter_valid_name".tr;
                        } else {
                          return null;
                        }
                      },
                      controller: logic.nameController,
                      prefixIcon: Iconsax.profile_circle,
                    ),
                    const SizedBox(height: 5),

                    //Phone TextField ----------------------------------
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "phone_number".tr,
                          style: Theme.of(context).textTheme.titleLarge,
                        )),
                    const SizedBox(height: 5),
                    CustomTextField(
                      hintText: "enter_number".tr,
                      validator: (value){
                        if(RegExp(r'^01[3-9][0-9]{8}$').hasMatch(value ?? '')){
                          return null;
                        }else{
                          return "please_enter_valid_phone_number".tr;
                        }
                      },
                      controller: logic.phoneController,
                      prefixIcon: Iconsax.call,
                    ),
                    const SizedBox(height: 24),
                    logic.updateLoading?const Center(child: CircularProgressIndicator(),): CustomButton(text: "update".tr, onTap: (){
                      if(formKey.currentState!.validate()){
                        logic.updateProfile();
                      }
                    }),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
