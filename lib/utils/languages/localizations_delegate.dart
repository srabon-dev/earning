import 'package:earning/constant/app_constants.dart';
import 'package:flutter/material.dart';
import 'languages_localizations.dart';

class TranslationsDelegate extends LocalizationsDelegate<LanguageTranslation> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => AppConstants.languagesList.contains(locale.languageCode);

  @override
  Future<LanguageTranslation> load(Locale locale) =>
      LanguageTranslation.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}