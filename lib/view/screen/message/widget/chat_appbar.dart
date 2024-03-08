import 'package:earning/constant/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget{
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(onPressed: (){
                Get.back();
              }, icon: const Icon(Iconsax.back_square,size: 28,),),
              const SizedBox(width: 5.0,),
              SizedBox(
                height: 36,
                width: 36,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(AppImages.profile),
                ),
              ),
              const SizedBox(width: 5.0,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Customer Support",style: Theme.of(context).textTheme.titleMedium,),
                  Text("24/7 Support",style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 10)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}