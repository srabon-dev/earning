import 'package:flutter/material.dart';

class AppConstants{
  static const String appName = "Opex";

  static const String privacyUrl = "https://opex.viewearningbd.com/privacy-policy.html";
  static const String termsUrl = "https://opex.viewearningbd.com/terms-of-service.html";

  static const String languageCode = "languagesCode";
  static const String countryCode = "countryCode";

  static const List<String> languagesList = ['en', 'bn'];
  static const List<Locale> localesList = [
    Locale('en', 'US'),
    Locale('bn', 'BD'),
  ];
}