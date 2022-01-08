import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Map<String, String>? _localizedValues;

  Future<void> load() async {
    String jsonStringValues =
        await rootBundle.loadString('lib/app/translations/${locale.languageCode}.json');
    log("locale Found");
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues = mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  ///translates a phrase using [key]
  ///
  ///returns its value from the localization json file
  String translate(String key) {
    return key.isEmpty || _localizedValues![key] == null || _localizedValues![key]!.isEmpty
        ? key
        : _localizedValues![key]!;
  }

  ///translates two phrases using [firstKey] and [secondKey]
  ///
  ///simply searches for [firstKey] and then in [firstKey] for [${}] and replaces it with [secondKey]
  ///if [firstKey] is not found ["Language resource Not Found"] is returned
  ///if [secondKey] is not found the value of the key will be returned
  ///
  ///returns the value from the localization json file
  String translateConcatenated(String firstKey, String secondKey) {
    return (firstKey.isEmpty ||
                _localizedValues![firstKey] == null ||
                _localizedValues![firstKey]!.isEmpty)
        ? firstKey
        : _localizedValues![firstKey]!.replaceAll('\${}',secondKey.isEmpty ||
        _localizedValues![secondKey] == null ||
        _localizedValues![secondKey]!.isEmpty ? secondKey : _localizedValues![secondKey]!);
  }

  // static member to have simple access to the delegate from Material App
  static const LocalizationsDelegate<AppLocalizations> delegate = _DemoLocalizationsDelegate();
}

class _DemoLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localization = AppLocalizations(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
