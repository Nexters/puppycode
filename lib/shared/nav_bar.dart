// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:puppycode/pages/feeds/feed.dart';
import 'package:puppycode/pages/home/home.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/styles/color.dart';

class ScreenWithNavBar extends StatefulWidget {
  const ScreenWithNavBar({super.key});

  @override
  State<ScreenWithNavBar> createState() => _ScreenWithNavBarState();
}

enum Tab { feed, home, my }

class _ScreenWithNavBarState extends State<ScreenWithNavBar>
    with WidgetsBindingObserver {
  Tab _currentTab = Tab.feed;
  static const List<Tab> _allowedRoutes = [Tab.feed, Tab.home, Tab.my];

  final Map<Tab, Widget> _pages = {
    Tab.feed: const FeedPage(),
    Tab.home: const HomePage(),
    Tab.my: const HomePage(),
  };

  @override
  void initState() {
    super.initState();
    var argTab = Get.arguments == null ? null : Get.arguments['tab'];

    if (_allowedRoutes.contains(argTab)) {
      _currentTab = argTab;
    }

    WidgetsBinding.instance.addObserver(this);
  }

  _changeTab(int index) {
    setState(() {
      var tab = _allowedRoutes[index];
      _currentTab = tab;
    });
  }

  BottomNavigationBarItem _createBottomNavigationBarItem(
      String assetName, String label) {
    return BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/icons/$assetName.svg'),
        icon: SvgPicture.asset(
          'assets/icons/$assetName.svg',
          colorFilter:
              const ColorFilter.mode(Color(0xFFBFC9D0), BlendMode.srcIn),
        ),
        label: label);
  }

  AppBarLeft _getAppBarLeft() {
    if (_currentTab == Tab.home) return AppBarLeft(iconType: LeftIconType.LOGO);
    if (_currentTab == Tab.feed) return AppBarLeft(label: '산책피드');
    return AppBarLeft(label: '산책일지');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppBar(
        leftOptions: _getAppBarLeft(),
      ),
      body: _pages[_currentTab],
      floatingActionButton:
          _currentTab == Tab.feed ? const WriteFloatingButton() : null,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 7),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: ThemeColor.gray2, width: 1))),
        child: BottomNavigationBar(
          currentIndex: _allowedRoutes.indexOf(_currentTab),
          onTap: (index) => _changeTab(index),
          selectedItemColor: ThemeColor.black,
          selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 10, letterSpacing: -1),
          unselectedItemColor: ThemeColor.gray4,
          unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 10, letterSpacing: -1),
          items: [
            _createBottomNavigationBarItem('feed', '피드'),
            _createBottomNavigationBarItem('home', '홈'),
            _createBottomNavigationBarItem('calendar', '산책일지'),
          ],
        ),
      ),
    );
  }
}

class WriteFloatingButton extends StatelessWidget {
  const WriteFloatingButton({
    super.key,
  });

  _onButtonClick(bool hasWritten) {
    if (hasWritten) return;
    Get.toNamed('/camera');
  }

  @override
  Widget build(BuildContext context) {
    var hasWritten = false;
    var floatingButtonColor =
        Theme.of(context).floatingActionButtonTheme.backgroundColor;

    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.13),
            blurRadius: 30,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: FloatingActionButton(
        elevation: 0,
        onPressed: () => {_onButtonClick(hasWritten)},
        backgroundColor: hasWritten ? Colors.white : floatingButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: SvgPicture.asset(
          'assets/icons/write.svg',
          colorFilter: hasWritten
              ? ColorFilter.mode(floatingButtonColor!, BlendMode.srcIn)
              : null,
          width: 32,
        ),
      ),
    );
  }
}
