import 'package:get/get.dart';
import 'package:puppycode/pages/home.dart';
import 'package:puppycode/pages/home/my_home.dart';
import 'package:puppycode/pages/onboarding/index.dart';
import 'package:puppycode/pages/onboarding/landing.dart';
import 'package:puppycode/pages/setting.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const HomePage()),
    GetPage(name: '/settings', page: () => const SettingPage()),
    GetPage(name: '/onboarding', page: () => const LandingPage()),
    GetPage(name: '/onboarding/name', page: () => const OnboardingPage()),
    GetPage(name: '/home', page: () => const MyHomePage()),
  ];
}
