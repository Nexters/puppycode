import 'package:get/get.dart';
import 'package:puppycode/pages/onboarding/index.dart';
import 'package:puppycode/pages/onboarding/landing.dart';
import 'package:puppycode/pages/feeds/write.dart';
import 'package:puppycode/pages/setting.dart';
import 'package:puppycode/shared/camera.dart';
import 'package:puppycode/shared/nav_bar.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const ScreenWithNavBar()),
    GetPage(name: '/settings', page: () => const SettingPage()),
    GetPage(name: '/onboarding', page: () => const LandingPage()),
    GetPage(name: '/onboarding/info', page: () => const OnboardingPage()),
    GetPage(name: '/create', page: () => const FeedWritePage()),
    GetPage(
        name: '/camera',
        page: () => const CameraScreen(),
        transition: Transition.downToUp),
  ];
}
