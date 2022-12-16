import 'dart:async';

import 'package:base_https/base_https.dart';
import 'package:base_utils/Utils/flutter_base/SecureStorageUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ussing_boilerplate_flutter/di/module/local_module.dart';

import 'constants/enum.dart';
import 'constants/env_configs.dart';
import 'data/securestorage/secure_storage_helper.dart';
import 'di/components/service_locator.dart';
import 'ui/my_app.dart';

void bootstraps({required Environment environment}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await setPreferredOrientations();
  await setupLocator();
  await setInitializeMethod();
  EnvConfig.setEnvironment(environment);
  return runZonedGuarded(() async {
    runApp(MyApp(env: environment));
  }, (error, stack) {
    debugPrint(stack.toString());
    debugPrint(error.toString());
  });
}


Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}

Future<void> setInitializeMethod() async {
  // Init secure storage
  await LocalModule.provideSecureStorage();
  // Init get token of https
  HttpHelper.funcGetToken = getIt<SecureStorageHelper>().authToken;
}