// ignore_for_file: non_constant_identifier_names

import 'package:puppycode/shared/http.dart';

class Config {
  static String env = 'production';
  static bool isLocal = false;
  static String TOKEN = '';
  static String? FIREBASE_TOKEN;

  Config(Map<String, dynamic> config, String? fcmToken) {
    if (fcmToken != null) FIREBASE_TOKEN = fcmToken;
    if (config['ENV'] == 'LOCAL') {
      env = 'local';
      isLocal = true;
      TOKEN = config['TEST_TOKEN'];
    } else {
      HttpService.setToken();
    }
  }
}
