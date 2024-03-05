import 'package:earning/constant/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isDarkMode?AppColors.whiteColor:AppColors.blackColor)
        ),
        child: Center(child: Text(text,style: Theme.of(context).textTheme.titleLarge)),
      ),
    );
  }
}