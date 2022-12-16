import 'dart:async';

import 'package:base_utils/Utils/flutter_base/Util.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async =>  await PreferUtil.getBool(Preferences.is_logged_in) ?? false;

  Future<bool> saveIsLoggedIn(bool value) async => await PreferUtil.setBool(Preferences.is_logged_in, value);

  // Theme:------------------------------------------------------
  Future<bool> get isDarkMode async => await PreferUtil.getBool(Preferences.is_dark_mode) ?? false;

  Future<bool> changeBrightnessToDark(bool value) async => await PreferUtil.setBool(Preferences.is_dark_mode, value);

  // Language:---------------------------------------------------
  Future<String?> get currentLanguage async => await PreferUtil.getString(Preferences.current_language);

  Future<bool> changeLanguage(String language) async => await PreferUtil.setString(Preferences.current_language, language);

}