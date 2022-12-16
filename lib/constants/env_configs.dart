// ignore_for_file: constant_identifier_names, duplicate_ignore

import 'enum.dart';

class EnvConfig {
  static late Map<String, dynamic> _config;

  static void setEnvironment(Environment env)  {
    switch (env) {
      case Environment.DEV:
        _config = _Config.debugConstants;
        break;
      case Environment.STAGING:
        _config = _Config.stagingConstants;
        break;
      case Environment.PROD:
        _config = _Config.prodConstants;
        break;
      default:
        _config = _Config.debugConstants;
        break;
    }
  }

  static get apiConfig => _config[_Config.API_CONFIG];

  static get apiWebView => _config[_Config.API_WEB_VIEW];

  static get clientSecret => _config[_Config.API_CLIENT_SECRET];

  static get apiBanner => _config[_Config.API_BANNER];

}

class _Config {

  static const API_CONFIG = 'API_CONFIG';
  static const API_WEB_VIEW = 'API_WEB_VIEW';
  static const API_CLIENT_SECRET = 'API_CLIENT_SECRET';
  static const API_BANNER = 'API_BANNER';

  static Map<String, dynamic> debugConstants = {
    API_CONFIG: 'https://gapi.giasan.vn/dev/g-evaluation/v1/api/v1/tin-dung/static/url-app-tin-dung',
    API_WEB_VIEW: 'https://account-sandbox.cenhomes.vn',
    API_CLIENT_SECRET: '9953150b-1aea-83f3-a4c9-d27bc4ca19ed',
    API_BANNER: 'https://gapi.giasan.vn/dev/g-evaluation/v1/api/v1/tin-dung/static/list-image-banner',
  };

  static Map<String, dynamic> stagingConstants = {
    API_CONFIG: 'https://gapi.giasan.vn/staging/g-evaluation/v1/api/v1/tin-dung/static/url-app-tin-dung',
    API_WEB_VIEW: 'https://account.cenhomes.vn',
    API_CLIENT_SECRET: 'e0d6ec06-ae9b-bbbc-6c00-56156e9a0ea8',
    API_BANNER: 'https://gapi.giasan.vn/staging/g-evaluation/v1/api/v1/tin-dung/static/list-image-banner',
  };

  static Map<String, dynamic> prodConstants = {
    API_CONFIG: 'https://gapi.cenhomes.vn/g-evaluation/v1/api/v1/tin-dung/static/url-app-tin-dung',
    API_WEB_VIEW: 'https://account.cenhomes.vn',
    API_CLIENT_SECRET: 'e0d6ec06-ae9b-bbbc-6c00-56156e9a0ea8',
    API_BANNER: 'https://gapi.giasan.vn/g-evaluation/v1/api/v1/tin-dung/static/list-image-banner',
  };
}
