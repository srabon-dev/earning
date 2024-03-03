import 'package:earning/constant/app_colors.dart';
import 'package:flutter/material.dart';

class TIconTheme{
  TIconTheme._();

  static IconThemeData lightIconTheme= const IconThemeData(
    color: AppColors.blackColor,
    size: 25,
  );


  static IconThemeData darkIconTheme = const IconThemeData(
    color: AppColors.whiteColor,
    size: 25,
  );
}