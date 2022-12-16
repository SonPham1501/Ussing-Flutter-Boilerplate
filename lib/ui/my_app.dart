import 'package:base_navigation/base_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

import '../constants/app_theme.dart';
import '../constants/enum.dart';
import '../constants/strings.dart';
import '../data/repository.dart';
import '../di/components/service_locator.dart';
import '../stores/language/language_store.dart';
import '../stores/post/post_store.dart';
import '../stores/theme/theme_store.dart';
import '../stores/user/user_store.dart';
import '../utils/locale/app_localization.dart';
import '../utils/routes/routes.dart';
import 'home/home.dart';
import 'login/login.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final ThemeStore _themeStore = ThemeStore(getIt<Repository>());
  final PostStore _postStore = PostStore(getIt<Repository>());
  final LanguageStore _languageStore = LanguageStore(getIt<Repository>());
  final UserStore _userStore = UserStore(getIt<Repository>());

  final Environment env;

  MyApp({Key? key, required this.env}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Phoenix(
      child: MultiProvider(
        providers: [
          Provider<ThemeStore>(create: (_) => _themeStore),
          Provider<PostStore>(create: (_) => _postStore),
          Provider<LanguageStore>(create: (_) => _languageStore),
        ],
        child: Observer(
          name: 'global-observer',
          builder: (context) {
            return MaterialApp(
              debugShowCheckedModeBanner: env == Environment.DEV,
              title: Strings.appName,
              navigatorKey: getIt<Navigation>().navigatorKey,
              theme: _themeStore.darkMode
                ? AppThemeData.darkThemeData
                : AppThemeData.lightThemeData,
              routes: Routes.routes,
              locale: Locale(_languageStore.locale),
              supportedLocales: _languageStore.supportedLanguages
                .map((language) => Locale(language.locale!, language.code))
                .toList(),
              localizationsDelegates: const [
                // A class which loads the translations from JSON files
                AppLocalizations.delegate,
                // Built-in localization of basic text for Material widgets
                GlobalMaterialLocalizations.delegate,
                // Built-in localization for text direction LTR/RTL
                GlobalWidgetsLocalizations.delegate,
                // Built-in localization of basic text for Cupertino widgets
                GlobalCupertinoLocalizations.delegate,
              ],
              home: _userStore.isLoggedIn ? const HomeScreen() : const LoginScreen(),
            );
          },
        ),
      ),
    );
  }
}
