/*
import 'package:earning/model/post_model.dart';
import 'package:earning/view/widget/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'widget/favorite_post_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(name: "Favorite",isBack: true,),
        body: ListView.separated(
          itemCount: 5,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox();
          },
          itemBuilder: (BuildContext context, int index) {
            return const FavoritePostCard(postModel: PostModel(),);
          },
        ),
      ),
    );
  }
}
*/
