// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class S {
  S();

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  // Supported locales
  static const List<Locale> supportedLocales = [
    Locale('en', ''), // English
  ];

  // Lookup for each string
  String get appName => Intl.message('Localization Demo', name: 'appName');
  String get welcome =>
      Intl.message('Welcome to Localization Demo!', name: 'welcome');
  String get chooseLanguage =>
      Intl.message('Choose Language', name: 'chooseLanguage');
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return S.supportedLocales.contains(locale);
  }

  @override
  Future<S> load(Locale locale) {
    final String name = locale.languageCode;
    final String localeName = Intl.canonicalizedLocale(name);

    Intl.defaultLocale = localeName;
    return load(locale);
  }

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}
