import 'package:earning/view/widget/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class EarningScreen extends StatelessWidget {
  const EarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(name: "My Earning"),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 18,vertical: 12),
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
