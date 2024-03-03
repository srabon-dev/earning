import 'package:earning/constant/app_colors.dart';
import 'package:flutter/material.dart';

class TFloatingActionButtonTheme{
  TFloatingActionButtonTheme._();

  static FloatingActionButtonThemeData lightFloatingActionButtonThemeData = const FloatingActionButtonThemeData(
    backgroundColor: AppColors.blackColor,
    foregroundColor: AppColors.whiteColor,
    iconSize: 25,
    elevation: 20,
  );


  static FloatingActionButtonThemeData darkFloatingActionButtonThemeData = const FloatingActionButtonThemeData(
    backgroundColor: AppColors.whiteColor,
    foregroundColor: AppColors.blackColor,
    iconSize: 25,
    elevation: 20,
  );
}