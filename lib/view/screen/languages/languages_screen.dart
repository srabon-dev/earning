import 'package:earning/constant/app_colors.dart';
import 'package:earning/constant/app_constants.dart';
import 'package:earning/controller/languages_controller.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:earning/view/widget/app_bar/custom_app_bar.dart';
import 'package:earning/view/widget/button/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SafeArea(
      child: GetBuilder<LocalizationController>(
          init: LocalizationController(),
          builder: (localizationController) {
            return Scaffold(
              appBar: Get.arguments? null: CustomAppBar(name: "languages".tr, isBack: true,),
              body: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("select_languages".tr,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        height: 8.0,
                        width: MediaQuery.of(context).size.width/3,
                        decoration: BoxDecoration(
                          color: isDarkMode?AppColors.whiteColor.withOpacity(0.2):AppColors.blackColor.withOpacity(0.2),
                        ),
                      ),
                      const SizedBox(height: 24),
                      //Languages Section

                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: (1/1),
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: localizationController.languages.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              localizationController.setLanguage(Locale(
                                AppConstants.languages[index].languageCode!,
                                AppConstants.languages[index].countryCode,
                              ));
                              localizationController.setSelectIndex(index);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
                              ),
                              child: Stack(children: [
                                Center(
                                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                                    Container(
                                      height: 65, width: 65,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.0),
                                        border: Border.all(color: Theme.of(context).textTheme.bodyLarge!.color!, width: 1),
                                      ),
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        localizationController.languages[index].imageUrl!, color: AppColors.greenColor,width: 36, height: 36),
                                    ),
                                    const SizedBox(height: 12.0),
                                    Text(localizationController.languages[index].languageName!),
                                  ]),
                                ),

                                localizationController.selectedIndex == index ? const Positioned(
                                  top: 0, right: 0,
                                  child: Icon(Icons.check_circle, size: 25),
                                ) : const SizedBox(),

                              ]),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12,),
                      Get.arguments? Text("you_can_later_change_the_language".tr,maxLines: 3,):const SizedBox(),
                      const SizedBox(height: 24),
                      Get.arguments? CustomButton(text: "save".tr, onTap: (){
                        if (FirebaseAuth.instance.currentUser != null) {
                          Future.delayed(const Duration(seconds: 1), () {
                            Get.offAllNamed(AppRoute.navScreen);
                          });
                        } else {
                          Future.delayed(const Duration(seconds: 1), () {
                            Get.offAllNamed(AppRoute.authIntroScreen);
                          });
                        }
                      }):const SizedBox(),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
