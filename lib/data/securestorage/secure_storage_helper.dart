

import 'package:base_utils/base_utils.dart';
import 'package:ussing_boilerplate_flutter/data/securestorage/constants/secure_storages.dart';

class SecureStorageHelper {

  // General Method: ---------------------------------------------------------------------------
  Future<String> authToken() async => SecureStorageUtil.getString(SecureStorages.auth_token);

  Future<void> saveAuthToken(String value) async => SecureStorageUtil.setString(SecureStorages.auth_token, value);

  Future<void> removeAuthToken() async => SecureStorageUtil.removeString(SecureStorages.auth_token);

}