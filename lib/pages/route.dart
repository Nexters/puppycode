import 'package:get/get.dart';
import 'package:puppycode/pages/home.dart';
import 'package:puppycode/pages/setting.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => HomePage()),
    GetPage(name: '/setting', page: () => SettingPage()),
  ];
}
