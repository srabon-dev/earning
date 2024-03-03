import 'package:cached_network_image/cached_network_image.dart';
import 'package:earning/constant/app_colors.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:earning/view/widget/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPostScreen extends StatelessWidget {
  const MyPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(name: "My Video"),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.blackColor),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width/4,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png',
                      ),
                    ),
                    const Column(
                      children: [
                        Text("Title"),
                        Text("Title"),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
