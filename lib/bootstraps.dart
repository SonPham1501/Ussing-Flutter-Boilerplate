import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/enum.dart';
import 'constants/env_configs.dart';
import 'di/components/service_locator.dart';
import 'ui/my_app.dart';

void bootstraps({required Environment environment}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await setPreferredOrientations();
  await setupLocator();
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