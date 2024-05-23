import 'package:earning/constant/app_colors.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:earning/view/widget/app_bar/custom_app_bar.dart';
import 'package:earning/view/widget/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(name: "verify".tr),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
          child: Column(
            children: [
              Text("benefits_of_account_verification".tr,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const Icon(
                    Iconsax.verify,
                    color: AppColors.greenColor,
                    size: 28,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Text("you_can_earn_money_by_posting_content".tr,
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(
                    Iconsax.verify,
                    color: AppColors.greenColor,
                    size: 28,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Text(
                        "you_will_get_green_tick_verification_icon_with_your_name".tr,
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(
                    Iconsax.verify,
                    color: AppColors.greenColor,
                    size: 28,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Text("you_will_get_coin_for_each_like".tr,
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(
                    Iconsax.verify,
                    color: AppColors.greenColor,
                    size: 28,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Text("you_can_make_10_post_per_day".tr,
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  const Icon(
                    Iconsax.verify,
                    color: AppColors.greenColor,
                    size: 28,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text("lifetime_earning".tr,
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              const SizedBox(height: 24),
              Text("requirement".tr,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const Icon(
                    Iconsax.verify,
                    color: AppColors.greenColor,
                    size: 28,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                      child: Text("one_time_payment".tr,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.titleMedium)),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Text("note".tr, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(width: 5.0),
              Text("if_you_provide_incorrect_information".tr,
                maxLines: 3,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppColors.redColor.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(text: "start_verification".tr, onTap: () {
                Get.offAllNamed(AppRoute.paymentScreen);
              }),
              const SizedBox(height: 12),
              CustomButton(
                  text: "skip".tr,
                  onTap: () {
                    Get.offAllNamed(AppRoute.navScreen);
                  }),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
