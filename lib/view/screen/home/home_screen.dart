import 'package:earning/controller/home_controller.dart';
import 'package:earning/view/widget/post/post_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widget/home_app_bar.dart';
import 'widget/home_create_post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (logic) {
          return Scaffold(
            appBar: const HomeAppBar(),
            body: Column(
              children: [
                const HomeCreatePost(),
                Expanded(
                  child: ListView.separated(
                    itemCount: 10,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return const PostCard();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
