import 'package:earning/constant/app_colors.dart';
import 'package:flutter/material.dart';

class TNavigationBarTheme{
  TNavigationBarTheme._();

  static NavigationBarThemeData lightNavigationBarTheme = NavigationBarThemeData(
    height: 80,
    elevation: 0,
    backgroundColor: AppColors.whiteColor,
    indicatorColor: AppColors.blackColor.withOpacity(0.1),
  );

  static NavigationBarThemeData darkNavigationBarTheme = NavigationBarThemeData(
    height: 80,
    elevation: 0,
    backgroundColor: AppColors.blackColor,
    indicatorColor: AppColors.whiteColor.withOpacity(0.4),
  );
}