import 'package:get/get.dart';
import 'package:puppycode/pages/home.dart';
import 'package:puppycode/pages/onboarding.dart';
import 'package:puppycode/pages/setting.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const HomePage()),
    GetPage(name: '/settings', page: () => SettingPage()),
    GetPage(name: '/onboarding/name', page: () => const OnboardingPage()),
  ];
}
