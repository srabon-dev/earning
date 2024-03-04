import 'package:earning/controller/my_post_controller.dart';
import 'package:earning/view/widget/app_bar/custom_app_bar.dart';
import 'package:earning/view/widget/post/post_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPostScreen extends StatelessWidget {
  const MyPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<MyPostController>(
        init: MyPostController(),
        builder: (logic) {
          return Scaffold(
            appBar: const CustomAppBar(name: "My Post"),
            body: ListView.separated(
              itemCount: 5,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox();
              },
              itemBuilder: (BuildContext context, int index) {
                return const PostCard(isMyPost: true,);
              },
            ),
          );
        }
      ),
    );
  }
}
