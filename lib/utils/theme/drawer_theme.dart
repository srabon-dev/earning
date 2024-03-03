import 'package:earning/constant/app_colors.dart';
import 'package:flutter/material.dart';

class TDrawerTheme{
  TDrawerTheme._();

  static DrawerThemeData lightDrawerTheme= DrawerThemeData(
    elevation: 20,
    backgroundColor: AppColors.whiteColor.withOpacity(0.5),
  );

  static DrawerThemeData darkDrawerTheme= DrawerThemeData(
    elevation: 20,
    backgroundColor: AppColors.blackColor.withOpacity(0.5),
  );
}