import 'package:earning/constant/app_colors.dart';
import 'package:earning/view/widget/jumping_dots/jumping_dots.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.orangeColor,
        ),
        child: isLoading?Center(
          child: JumpingDots(
            color: Colors.white,
            radius: 10,
            numberOfDots: 3,
          ),
        ):Center(child: Text(text,style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.whiteColor,
        ))),
      ),
    );
  }
}