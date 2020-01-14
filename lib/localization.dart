import 'package:flutter/material.dart';

class FlutterBlocLocalizations {
  static FlutterBlocLocalizations of(BuildContext context) {
    return Localizations.of<FlutterBlocLocalizations>(
        context, FlutterBlocLocalizations);
  }

  String get appTitle {
    return 'Todos';
  }
}

class FlutterBlocLocalizationsDelegate
    extends LocalizationsDelegate<FlutterBlocLocalizations> {
  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return locale.languageCode.toLowerCase().contains('en');
  }

  @override
  Future<FlutterBlocLocalizations> load(Locale locale) {
    // TODO: implement load
    return Future(() {
      return FlutterBlocLocalizations();
    });
  }

  @override
  bool shouldReload(LocalizationsDelegate<FlutterBlocLocalizations> old) {
    // TODO: implement shouldReload
    return false;
  }
}
