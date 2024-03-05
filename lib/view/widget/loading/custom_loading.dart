import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key, required this.height, required this.width, this.opacity=0.04, this.borderRadius= 12});
  final double height;
  final double width;
  final double opacity;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(opacity),
          borderRadius: BorderRadius.circular(borderRadius),
        )
    );
  }
}