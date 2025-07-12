import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  String _appLocale = "en";

  String get appLocale => _appLocale;

  set appLocale(String locale) {
    _appLocale = locale;
    notifyListeners();
  }
}
