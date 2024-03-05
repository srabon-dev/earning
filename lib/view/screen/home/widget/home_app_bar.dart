import 'dart:developer';
import 'package:earning/constant/app_constants.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget{
  const HomeAppBar({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;
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
          IconButton(onPressed: (){
            try{
              scaffoldKey.currentState?.openDrawer();
            }catch(error){
              log(error.toString());
            }
          }, icon: const Icon(Iconsax.menu,size: 28,),),
          const Text(AppConstants.appName,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 32,fontFamily: "Bold"),),
          IconButton(onPressed: () async {
            /*await FirebaseAuth.instance.signOut().then((value){
              Get.offAndToNamed(AppRoute.loginScreen);
            }).onError((error, stackTrace){
              log(error.toString());
            });*/
          }, icon: const Icon(Iconsax.notification,size: 28,),),
        ],
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
