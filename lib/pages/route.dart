import 'package:get/get.dart';
import 'package:puppycode/pages/friends_list.dart';
import 'package:puppycode/pages/setting/setting.dart';
import 'package:puppycode/pages/setting/user_info.dart';
import 'package:puppycode/pages/onboarding/index.dart';
import 'package:puppycode/pages/onboarding/landing.dart';
import 'package:puppycode/pages/feeds/write.dart';
import 'package:puppycode/shared/nav_bar.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const ScreenWithNavBar()),
    GetPage(name: '/settings', page: () => const SettingPage()),
    GetPage(name: '/onboarding', page: () => const LandingPage()),
    GetPage(name: '/onboarding/name', page: () => const OnboardingPage()),
    GetPage(name: '/create', page: () => const FeedWritePage()),
    GetPage(name: '/settings/userInfo', page: () => const UserInfoPage()),
    GetPage(name: '/settings/friends', page: () => const FriendsListPage())
  ];
}
