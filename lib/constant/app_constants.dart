import 'package:earning/constant/app_images.dart';
import 'package:earning/model/languages_model.dart';
import 'package:flutter/material.dart';

class AppConstants{
  static const String appName = "Opex";

  static const String privacyUrl = "https://opex.viewearningbd.com/privacy-policy.html";
  static const String termsUrl = "https://opex.viewearningbd.com/terms-of-service.html";

  static const String languageCode = "languagesCode";
  static const String countryCode = "countryCode";
  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: AppImages.englandFlag, languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: AppImages.bangladeshFlag, languageName: 'Bengali', countryCode: 'BN', languageCode: 'bn'),
   ];
}