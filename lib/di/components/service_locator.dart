import 'package:base_navigation/base_navigation.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ussing_boilerplate_flutter/data/securestorage/secure_storage_helper.dart';

import '../../data/network/apis/posts/post_api.dart';
import '../../data/repository.dart';
import '../../data/sharedpref/shared_preference_helper.dart';
import '../../stores/error/error_store.dart';
import '../../stores/form/form_store.dart';
import '../../stores/language/language_store.dart';
import '../../stores/post/post_store.dart';
import '../../stores/theme/theme_store.dart';
import '../../stores/user/user_store.dart';
import '../module/local_module.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // factories:-----------------------------------------------------------------
  getIt.registerFactory(() => ErrorStore());
  getIt.registerFactory(() => FormStore());
  getIt.registerFactory(() => LocalModule.provideSecureStorage());

  // async singletons:----------------------------------------------------------
  getIt.registerSingletonAsync<Database>(() => LocalModule.provideDatabase());
  getIt.registerSingletonAsync<SharedPreferences>(() => LocalModule.provideSharedPreferences());

  // singletons:----------------------------------------------------------------
  getIt.registerSingleton(SharedPreferenceHelper());
  getIt.registerSingleton(SecureStorageHelper());
  getIt.registerSingleton(Navigation());

  // api's:---------------------------------------------------------------------
  getIt.registerSingleton(PostApi());

  // data sources
  // getIt.registerSingleton(PostDataSource(await getIt.getAsync<Database>()));

  // repository:----------------------------------------------------------------
  getIt.registerSingleton(Repository(
    postApi: getIt<PostApi>(),
    sharedPrefsHelper: getIt<SharedPreferenceHelper>(),
    secureStorageHelper: getIt<SecureStorageHelper>(),
  ));

  // stores:--------------------------------------------------------------------
  getIt.registerSingleton(LanguageStore(getIt<Repository>()));
  getIt.registerSingleton(PostStore(getIt<Repository>()));
  getIt.registerSingleton(ThemeStore(getIt<Repository>()));
  getIt.registerSingleton(UserStore(getIt<Repository>()));
}
