import 'package:earning/constant/app_colors.dart';
import 'package:flutter/material.dart';

class TTextTheme{
  TTextTheme._();
  static TextTheme lightTextTheme = TextTheme(

    titleLarge: const TextStyle().copyWith(
        fontFamily: "Bold",
        color: AppColors.blackColor,
        fontSize: 18
    ),
    titleSmall: const TextStyle().copyWith(
        fontFamily: "Bold",
        color: AppColors.blackColor,
        fontSize: 16
    ),
  );

  static TextTheme darkTextTheme = TextTheme(

    titleLarge: const TextStyle().copyWith(
        fontFamily: "Bold",
        color: AppColors.whiteColor,
        fontSize: 18
    ),
    titleSmall: const TextStyle().copyWith(
        fontFamily: "Bold",
        color: AppColors.whiteColor,
        fontSize: 16
    ),
  );
}