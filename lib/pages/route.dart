import 'package:get/get.dart';
import 'package:puppycode/pages/friends_list.dart';
import 'package:puppycode/pages/home.dart';
import 'package:puppycode/pages/onboarding.dart';
import 'package:puppycode/pages/setting/setting.dart';
import 'package:puppycode/pages/setting/user_info.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const HomePage()),
    GetPage(name: '/settings', page: () => const SettingPage()),
    GetPage(name: '/onboarding/name', page: () => const OnboardingPage()),
    GetPage(name: '/settings/userInfo', page: () => const UserInfoPage()),
    GetPage(name: '/settings/friends', page: () => const FriendsListPage())
  ];
}
