import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({super.key,
    required this.name,
    this.onTap,
    this.icon,
    this.isBack= false,
    this.rightOnTap});

  final String name;
  final IconData? icon;
  final bool isBack;
  final VoidCallback? rightOnTap;
  final VoidCallback? onTap;
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: rightOnTap == null && isBack == false?MainAxisAlignment.center:(rightOnTap != null?MainAxisAlignment.spaceBetween : MainAxisAlignment.start),
        children: [
          isBack?IconButton(onPressed: onTap ?? (){
            Get.back();
          }, icon: const Icon(Iconsax.back_square,size: 28,),):const Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: SizedBox(),
          ),
          Text(name,style: const TextStyle(fontWeight: FontWeight.w800,fontSize: 18,fontFamily: "Bold"),),
          rightOnTap != null?IconButton(onPressed: rightOnTap, icon: Icon(icon,size: 24,),):const SizedBox(),
        ],
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}