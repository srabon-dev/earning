import 'package:earning/view/widget/app_bar/custom_app_bar.dart';
import 'package:earning/view/widget/post/post_card.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(name: "Favorite",isBack: true,),
        body: ListView.separated(
          itemCount: 5,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox();
          },
          itemBuilder: (BuildContext context, int index) {
            return const PostCard(isFavorite: true,);
          },
        ),
      ),
    );
  }
}
