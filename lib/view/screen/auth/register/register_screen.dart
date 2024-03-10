import 'package:earning/constant/app_colors.dart';
import 'package:earning/constant/app_images.dart';
import 'package:earning/controller/auth_controller.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:earning/view/widget/app_bar/custom_app_bar.dart';
import 'package:earning/view/widget/button/custom_button.dart';
import 'package:earning/view/widget/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (logic) {
          return SafeArea(
            child: Scaffold(
              appBar: CustomAppBar(name: "create_account".tr,isBack: true),
              body: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Logo--------------------------
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: Image.asset(AppImages.logo),
                      ),

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

                      //Email TextField ---------------------------------
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "email".tr,
                            style: Theme.of(context).textTheme.titleLarge,
                          )),
                      const SizedBox(height: 5),
                      CustomTextField(
                        hintText: "enter_email".tr,
                        validator: (email) {
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email);
                          if (emailValid) {
                            return null;
                          } else {
                            return "please_enter_valid_email_address".tr;
                          }
                        },
                        controller: logic.emailRController,
                        prefixIcon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 12),

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
                        textInputType: TextInputType.number,
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
                      const SizedBox(height: 12),

                      //Password TextField -------------------------------
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "password".tr,
                            style: Theme.of(context).textTheme.titleLarge,
                          )),
                      const SizedBox(height: 5),
                      CustomTextField(
                        hintText: "enter_password".tr,
                        validator: (password) {
                          if (logic.passwordRController.text == "") {
                            return "please_enter_valid_password".tr;
                          } else if (logic.passwordRController.text.length <
                              6) {
                            return "password_must_be_characters".tr;
                          } else {
                            return null;
                          }
                        },
                        controller: logic.passwordRController,
                        isPassword: true,
                        prefixIcon: Iconsax.lock,
                      ),
                      const SizedBox(height: 12),

                      //Confirm Password TextField ------------------------
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "confirm_password".tr,
                            style: Theme.of(context).textTheme.titleLarge,
                          )),
                      const SizedBox(height: 5),
                      CustomTextField(
                        hintText: "confirm_password".tr,
                        validator: (conPassword) {
                          if (logic.confirmPasswordRController.text !=
                              logic.passwordRController.text) {
                            return "password_do_not_match".tr;
                          } else {
                            return null;
                          }
                        },
                        controller: logic.confirmPasswordRController,
                        isPassword: true,
                        prefixIcon: Iconsax.lock,
                      ),
                      const SizedBox(height: 24),
                      logic.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : CustomButton(
                              text: "create_account".tr,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  logic.register();
                                }
                              }),
                      const SizedBox(height: 44),
                      Text("already_have_an_account".tr),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: ()=>Get.toNamed(AppRoute.loginScreen),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15.0),
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: isDarkMode?AppColors.blackColor:AppColors.whiteColor,
                            border: Border.all(color: isDarkMode?AppColors.whiteColor:AppColors.blackColor)
                          ),
                          child: Center(child: Text("login".tr,style: Theme.of(context).textTheme.titleMedium,),),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Get.toNamed(AppRoute.termsOfService);
                            },
                            child: Text("terms_of_ues".tr,style: TextStyle(
                              color: AppColors.greenColor,
                            )),
                          ),
                          const SizedBox(width: 5.0),
                          Text("and".tr),
                          const SizedBox(width: 5.0),
                          GestureDetector(
                            onTap: (){
                              Get.toNamed(AppRoute.privacyPolicy);
                            },
                            child: Text("privacy_policy".tr,style: TextStyle(
                              color: AppColors.greenColor,
                            )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 44),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
