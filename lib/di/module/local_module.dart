// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:base_utils/base_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/local/constants/db_constants.dart';
import 'package:path/path.dart' as p;
import '../../utils/encryption/xxtea.dart';

abstract class LocalModule {


  /// A singleton preference provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Future<SharedPreferences> provideSharedPreferences() {
    return SharedPreferences.getInstance();
  }

  /// A singleton secure storage provider
  ///
  /// Calling it multiple times will return the same instance
  static Future<void> provideSecureStorage() {
    return SecureStorageUtil.init();
  }

  /// A singleton database provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Future<Database> provideDatabase() async {
    // Key for encryption
    var encryptionKey = "";

    // Get a platform-specific directory where persistent app data can be stored
    final appDocumentDir = await getApplicationDocumentsDirectory();

    // Path with the form: /platform-specific-directory/demo.db
    final dbPath = p.join(appDocumentDir.path, DBConstants.DB_NAME);

    // Check to see if encryption is set, then provide codec
    // else init normal db with path
    Database database;
    if (encryptionKey.isNotEmpty) {
      // Initialize the encryption codec with a user password
      var codec = getXXTeaCodec(password: encryptionKey);
      database = await databaseFactoryIo.openDatabase(dbPath, codec: codec);
    } else {
      database = await databaseFactoryIo.openDatabase(dbPath);
    }

    // Return database instance
    return database;
  }
}
