import 'dart:developer';
import 'package:earning/constant/app_constants.dart';
import 'package:earning/utils/languages/languages_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagesController extends GetxController {


  void onLocaleChange(Locale locale) async {
    LanguageTranslation.load(locale);
  }

  Future<void> getStoreLocal() async {
    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      onLocaleChange(
        Locale(
          sharedPreferences.getString(AppConstants.languageCode) ?? "en",
          sharedPreferences.getString(AppConstants.countryCode) ?? "US",
        ),
      );
    }catch(error){
      log(error.toString());
    }
  }

  @override
  void onInit() {
    getStoreLocal();
    super.onInit();
  }
}
