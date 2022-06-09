import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// There 3 places which you need to update to add new localisation
///  - assets/locate
///  - current file in `isSupported`
///  - in main.dart in `supportedLocales`
class AppLocalizations {

  static final AppLocalizations _singleton = new AppLocalizations._internal();
  AppLocalizations._internal();
  static AppLocalizations get instance => _singleton;

  Map<dynamic, dynamic>? _localisedValues;

  Future<AppLocalizations> load(Locale locale) async {
    String jsonContent =
    await rootBundle.loadString("assets/locale/localization_${locale.languageCode}.json");
        _localisedValues = json.decode(jsonContent);
    return this;
  }

  String text(String key) {
    return _localisedValues![key] ?? "$key not found";
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale)  {
    return AppLocalizations.instance.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => true;
}
