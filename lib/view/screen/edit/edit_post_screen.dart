import 'package:cached_network_image/cached_network_image.dart';
import 'package:earning/constant/app_colors.dart';
import 'package:earning/constant/app_images.dart';
import 'package:earning/controller/edit_post_controller.dart';
import 'package:earning/view/widget/app_bar/custom_app_bar.dart';
import 'package:earning/view/widget/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditPostScreen extends StatelessWidget {
  const EditPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SafeArea(
      child: GetBuilder<EditPostController>(
          init: EditPostController(),
          builder: (logic) {
            return Scaffold(
              appBar: CustomAppBar(name: "edit_post".tr, isBack: true),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color:
                        isDarkMode ? AppColors.blackColor : AppColors.whiteColor,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: logic.userModel.image != null && logic.userModel.image != ''?CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                            const Center(child: CircularProgressIndicator()),
                                            errorWidget: (context, url, error) =>
                                            const Center(child: Icon(Icons.error)),
                                            imageUrl: logic.userModel.image!): Image.asset(AppImages.profile,fit: BoxFit.cover,),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(logic.userModel.name??"",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(
                                      Iconsax.verify,
                                      size: 18,
                                      color: AppColors.greenColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8.0,),
                          TextFormField(
                            maxLines: 10,
                            minLines: 5,
                            maxLength: 1000,
                            controller: logic.descriptionController,
                            decoration: InputDecoration(
                              hintText: "write_interesting_content_get_more_likes_and_earn_more".tr,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: isDarkMode?AppColors.whiteColor:AppColors.blackColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: isDarkMode?AppColors.whiteColor:AppColors.blackColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: isDarkMode?AppColors.whiteColor:AppColors.blackColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: AppColors.redColor),
                              ),
                            ),
                          ),
                          // SizedBox(height: 12,),
                          GestureDetector(
                            onTap: (){
                              logic.showCameraPickDialog(context);
                            },
                            child: logic.postImage != null? Container(
                              height: height/3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: isDarkMode?AppColors.whiteColor.withOpacity(0.3) : AppColors.blackColor.withOpacity(0.2),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(logic.postImage!,fit: BoxFit.cover,),
                              ),
                            ): logic.imageURL != ""?Container(
                              height: height/3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: isDarkMode?AppColors.whiteColor.withOpacity(0.3) : AppColors.blackColor.withOpacity(0.2),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                    const Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                    const Center(child: Icon(Icons.error)),
                                    imageUrl: logic.imageURL),
                              ),
                            ):Container(
                              height: height/5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor)
                              ),
                              child: const Center(child: Icon(Iconsax.gallery,size: 50,),),
                            ),
                          ),
                          const SizedBox(height: 24,),
                          logic.updateLoading?const Center(child: CircularProgressIndicator(),) : CustomButton(text: "update".tr, onTap: (){
                            if(logic.descriptionController.text != ""){
                              logic.updatePost(docId: Get.arguments);
                            }else{
                              Fluttertoast.showToast(msg: "please_enter_all_information".tr);
                            }
                          }),
                        ],
                      ),
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
