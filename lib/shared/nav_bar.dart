import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puppycode/pages/feeds/feed.dart';
import 'package:puppycode/pages/home/my_home.dart';

class ScreenWithNavBar extends StatefulWidget {
  const ScreenWithNavBar({super.key});

  @override
  State<ScreenWithNavBar> createState() => _ScreenWithNavBarState();
}

class _ScreenWithNavBarState extends State<ScreenWithNavBar>
    with WidgetsBindingObserver {
  String _currentTab = 'home';
  static const List<String> _allowedRoutes = ['feed', 'home', 'my'];

  final Map<String, Widget> _pages = {
    'feed': const FeedPage(),
    'home': const MyHomePage(),
    'my': const MyHomePage(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _pages[_currentTab],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border:
                Border(top: BorderSide(color: Color(0xFFEFF2F5), width: 1))),
        child: BottomNavigationBar(
            currentIndex: _allowedRoutes.indexOf(_currentTab),
            onTap: (index) => _changeTab(index),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'feed'),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '나의산책'),
            ],
            showUnselectedLabels: false),
      ),
    );
  }
}
