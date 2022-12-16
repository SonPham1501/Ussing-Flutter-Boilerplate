import 'dart:async';

import 'bootstraps.dart';
import 'constants/enum.dart';


Future<void> main() async {
  const Environment environment = Environment.DEV;
  bootstraps(environment: environment);
}

