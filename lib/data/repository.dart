import 'dart:async';

import 'package:sembast/sembast.dart';
import 'package:ussing_boilerplate_flutter/data/securestorage/secure_storage_helper.dart';

import '../models/post/post.dart';
import '../models/post/post_list.dart';
import 'local/constants/db_constants.dart';
import 'network/apis/posts/post_api.dart';
import 'sharedpref/shared_preference_helper.dart';

class Repository {
  // api objects
  final PostApi _postApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // secure storage object

  final SecureStorageHelper _secureStorageHelper;

  // constructor
  Repository({
    required PostApi postApi,
    required SharedPreferenceHelper sharedPrefsHelper,
    required SecureStorageHelper secureStorageHelper,
  }) : _postApi = postApi,
       _sharedPrefsHelper = sharedPrefsHelper,
       _secureStorageHelper = secureStorageHelper;

  // Post: ---------------------------------------------------------------------
  Future<PostList> getPosts() async => await _postApi.getPosts().catchError((error) => throw error);

  // Login:---------------------------------------------------------------------
  Future<bool> login(String email, String password) async {
    return await Future.delayed(const Duration(seconds: 2), ()=> true);
  }

  Future<void> saveIsLoggedIn(bool value) => _sharedPrefsHelper.saveIsLoggedIn(value);

  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) => _sharedPrefsHelper.changeBrightnessToDark(value);

  Future<bool> get isDarkMode async => await _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) => _sharedPrefsHelper.changeLanguage(value);

  Future<String?> get currentLanguage async => await _sharedPrefsHelper.currentLanguage;
}