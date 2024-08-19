import 'package:puppycode/shared/http.dart';

class Config {
  static String env = 'production';
  static bool isLocal = false;
  // ignore: non_constant_identifier_names
  static String TOKEN = '';

  Config(Map<String, dynamic> config) {
    if (config['ENV'] == 'LOCAL') {
      env = 'local';
      isLocal = true;
      TOKEN = config['TEST_TOKEN'];
    } else {
      HttpService.setToken();
    }
  }
}
