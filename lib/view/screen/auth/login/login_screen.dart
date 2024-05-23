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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              appBar: CustomAppBar(name: "login".tr, isBack: true),
              body: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Logo Section ------------------------
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: Image.asset(AppImages.logo),
                      ),

                      //Email TextField -----------------------
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
                        controller: logic.emailController,
                        prefixIcon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 12),

                      //Password TextField ------------------------
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
                          if (password == null && password == "") {
                            return "please_enter_valid_password".tr;
                          } else if (password.length < 5) {
                            return "password_must_be_characters".tr;
                          } else {
                            return null;
                          }
                        },
                        controller: logic.passwordController,
                        isPassword: true,
                        prefixIcon: Iconsax.lock,
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      //Forget Password -----------------------
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoute.forgetPassword);
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "forget_password1".tr,
                            style: const TextStyle(color: AppColors.greenColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      //Login Button ---------------------------
                      logic.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : CustomButton(
                              text: "login".tr,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  logic.login();
                                }
                              }),

                      //Navigate Register Screen ------------------
                      const SizedBox(height: 44),
                      Text("do_not_have_an_account".tr),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoute.registerScreen),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 15.0),
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: isDarkMode
                                  ? AppColors.blackColor
                                  : AppColors.whiteColor,
                              border: Border.all(
                                  color: isDarkMode
                                      ? AppColors.whiteColor
                                      : AppColors.blackColor)),
                          child: Center(
                            child: Text(
                              "create_account".tr,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoute.termsOfService);
                            },
                            child: Text("terms_of_ues".tr,
                                style: const TextStyle(
                                  color: AppColors.greenColor,
                                )),
                          ),
                          const SizedBox(width: 5.0),
                          Text("and".tr),
                          const SizedBox(width: 5.0),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoute.privacyPolicy);
                            },
                            child: Text("privacy_policy".tr,
                                style: const TextStyle(
                                  color: AppColors.greenColor,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
