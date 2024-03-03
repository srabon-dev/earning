import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({super.key,
    required this.name,
    this.onTap,
    this.isBack= false,
    this.notification});

  final String name;
  final bool isBack;
  final VoidCallback? notification;
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isBack?IconButton(onPressed: onTap, icon: const Icon(Iconsax.back_square,size: 28,),):const Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: SizedBox(),
          ),
          Text(name,style: const TextStyle(fontWeight: FontWeight.w800,fontSize: 24,fontFamily: "Bold"),),
          notification != null?IconButton(onPressed: notification, icon: const Icon(Iconsax.notification,size: 24,),):const SizedBox(),
        ],
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}