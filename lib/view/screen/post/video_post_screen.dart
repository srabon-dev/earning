import 'package:earning/view/widget/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class VideoPostScreen extends StatelessWidget {
  const VideoPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(name: "Post Video",isBack: true,),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
