import 'package:earning/constant/app_colors.dart';
import 'package:earning/view/widget/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(name: "Verify Account",isBack: true),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 12.0),
          child: Column(
            children: [
              Text("Benefits of Account Verification",style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12,),
              Row(
                children: [
                  const Icon(Iconsax.verify,color: AppColors.greenColor,size: 28,),
                  const SizedBox(width: 5,),
                  Text("You can earn money by posting content.",style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(Iconsax.verify,color: AppColors.greenColor,size: 28,),
                  const SizedBox(width: 5,),
                  Text("You will get green tick verification icon with your profile.",style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(Iconsax.verify,color: AppColors.greenColor,size: 28,),
                  const SizedBox(width: 5,),
                  Text("You will get BDT 0.5Tk for each like.",style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(Iconsax.verify,color: AppColors.greenColor,size: 28,),
                  const SizedBox(width: 5,),
                  Text("You can make one post per day.",style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              const SizedBox(height: 8.0,),
              Row(
                children: [
                  const Icon(Iconsax.verify,color: AppColors.greenColor,size: 28,),
                  const SizedBox(width: 5,),
                  Text("Lifetime Earning",style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              const SizedBox(height: 24),
              Text("Requirement",style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12,),
              Row(
                children: [
                  const Icon(Iconsax.verify,color: AppColors.greenColor,size: 28,),
                  const SizedBox(width: 5,),
                  Flexible(child: Text("NID, note - NID card of the person whose name the account is opened.",maxLines: 2,style: Theme.of(context).textTheme.titleMedium)),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(Iconsax.verify,color: AppColors.greenColor,size: 28,),
                  const SizedBox(width: 5,),
                  Flexible(child: Text("One Time Payment BDT 5000Tk",maxLines: 2,style: Theme.of(context).textTheme.titleMedium)),
                ],
              ),
              const SizedBox(height: 24,),
              Row(
                children: [
                  Text("Note",style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(width: 5.0),
                  Flexible(child: Text("If you provide wrong information your account will be suspended",maxLines: 3,style: TextStyle(color: AppColors.redColor.withOpacity(0.5)),))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
