import 'package:cached_network_image/cached_network_image.dart';
import 'package:earning/constant/app_colors.dart';
import 'package:earning/view/widget/app_bar/custom_app_bar.dart';
import 'package:earning/view/widget/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(name: "Create Post", isBack: true),
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
                                  child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      imageUrl:
                                          "https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA4L2pvYjEwMzQtZWxlbWVudC0wNi0zOTcucG5n.png"),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Srabon Bapari",
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
                      maxLines: 6,
                      minLines: 2,
                      maxLength: 800,
                      decoration: InputDecoration(
                        hintText: "Write interesting content, get more likes and earn more...",
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
                    Container(
                      height: height/5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor)
                      ),
                      child: const Center(child: Icon(Iconsax.gallery,size: 50,),),
                    ),
                    const SizedBox(height: 12,),
                    CustomButton(text: "Post", onTap: (){}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
