import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localization.dart';

enum AppLanguages { ar, en }

class LocalizationManager {

 static Locale localeFactory(AppLanguages lang) {
    switch (lang) {
      case AppLanguages.en:
        return const Locale('en', '');
      case AppLanguages.ar:
        return const Locale('ar', '');
      default:
        return const Locale('en', '');
    }
  }

  static get createLocalizationsDelegates => [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    DefaultCupertinoLocalizations.delegate,
  ];

 static get createSupportedLocals => const [
   Locale('en', ''), // English
   Locale('ar', ''), // Arabic
 ];
}

extension Translation on String {
  String tr(BuildContext context) =>
      AppLocalizations.of(context).text(this);
}
