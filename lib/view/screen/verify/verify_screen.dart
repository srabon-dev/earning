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
        appBar: const CustomAppBar(name: "Verify"),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
          child: Column(
            children: [
              Text("Benefits of Account Verification",
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
                  Text("You can earn money by posting content.",
                      style: Theme.of(context).textTheme.titleMedium),
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
                  Text(
                      "You will get green tick verification icon with your name.",
                      style: Theme.of(context).textTheme.titleMedium),
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
                  Text("You will get 1 Coin for each like. and If you like other people's post then you will get 1 coin",
                      style: Theme.of(context).textTheme.titleMedium),
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
                  Text("You can make 10 post per day.",
                      style: Theme.of(context).textTheme.titleMedium),
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
                  Text("Lifetime Earning",
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              const SizedBox(height: 24),
              Text("Requirement",
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
                      child: Text(
                          "NID / Date of Birth /Any Government Document - NID card or Date of Birth or Any Government Document of the person whose name the account is opened.",
                          maxLines: 3,
                          style: Theme.of(context).textTheme.titleMedium)),
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
                      child: Text("One Time Payment BDT 5000Tk",
                          maxLines: 2,
                          style: Theme.of(context).textTheme.titleMedium)),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Text("Note", style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(width: 5.0),
              Text(
                "If you provide incorrect information, your account will not be accepted and the account from which you will pay will be refunded.",
                maxLines: 3,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppColors.redColor.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(text: "Start Verification", onTap: () {

              }),
              const SizedBox(height: 12),
              CustomButton(
                  text: "Skip",
                  onTap: () {
                    Get.offAndToNamed(AppRoute.navScreen);
                  }),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
