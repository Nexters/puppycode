import 'package:get/get.dart';
import 'package:puppycode/pages/setting/friends_list.dart';
import 'package:puppycode/pages/home.dart';
import 'package:puppycode/pages/home/my_home.dart';
import 'package:puppycode/pages/onboarding/index.dart';
import 'package:puppycode/pages/onboarding/landing.dart';
import 'package:puppycode/pages/posts/write.dart';
import 'package:puppycode/pages/setting/setting.dart';
import 'package:puppycode/pages/setting/user_info.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const HomePage()),
    GetPage(name: '/settings', page: () => const SettingPage()),
    GetPage(name: '/onboarding', page: () => const LandingPage()),
    GetPage(name: '/onboarding/name', page: () => const OnboardingPage()),
    GetPage(name: '/home', page: () => const MyHomePage()),
    GetPage(name: '/create', page: () => const PostWritePage()),
    GetPage(name: '/settings/userInfo', page: () => const UserInfoPage()),
    GetPage(name: '/settings/friends', page: () => const FriendsListPage())
  ];
}
