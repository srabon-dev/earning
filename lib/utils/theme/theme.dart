import 'package:earning/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'drawer_theme.dart';
import 'floating_theme.dart';
import 'icon_theme.dart';
import 'nav_theme.dart';
import 'text_theme.dart';

class TAppTheme{
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Medium',
    brightness: Brightness.light,
    primaryColor: AppColors.whiteColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    textTheme: TTextTheme.lightTextTheme,
    iconTheme: TIconTheme.lightIconTheme,
    drawerTheme: TDrawerTheme.lightDrawerTheme,
    floatingActionButtonTheme: TFloatingActionButtonTheme.lightFloatingActionButtonThemeData,
    navigationBarTheme: TNavigationBarTheme.lightNavigationBarTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Medium',
    brightness: Brightness.dark,
    primaryColor: AppColors.blackColor,
    scaffoldBackgroundColor: AppColors.blackColor,
    textTheme: TTextTheme.darkTextTheme,
    iconTheme: TIconTheme.darkIconTheme,
    drawerTheme: TDrawerTheme.darkDrawerTheme,
    floatingActionButtonTheme: TFloatingActionButtonTheme.darkFloatingActionButtonThemeData,
    navigationBarTheme: TNavigationBarTheme.darkNavigationBarTheme,
  );
}