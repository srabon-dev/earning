import 'dart:ui';
import 'package:earning/constant/app_images.dart';
import 'package:flutter/material.dart';

class ImageLoading extends StatelessWidget {
  const ImageLoading({super.key});


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: const SizedBox(),
          ),
        ),
        Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      AppImages.logo,
                      height: 60,
                      width: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 2,
          left: 2,
          right: 2,
          bottom: 2,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            backgroundColor: Colors.orange,
          ),
        ),
      ],
    );
  }
}
