// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:puppycode/config.dart';
import 'package:puppycode/pages/feeds/feed.dart';
import 'package:puppycode/pages/feeds/my/myfeed.dart';
import 'package:puppycode/pages/home/home.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/states/user.dart';
import 'package:puppycode/shared/typography/body.dart';

class ScreenWithNavBar extends StatefulWidget {
  const ScreenWithNavBar({super.key});

  @override
  State<ScreenWithNavBar> createState() => _ScreenWithNavBarState();
}

enum NavTab { feed, home, my }

class _ScreenWithNavBarState extends State<ScreenWithNavBar>
    with WidgetsBindingObserver {
  NavTab _currentTab = NavTab.home;
  static const List<NavTab> _allowedRoutes = [
    NavTab.feed,
    NavTab.home,
    NavTab.my
  ];

  final Map<NavTab, Widget> _pages = {
    NavTab.feed: const FeedScreen(),
    NavTab.home: const HomePage(),
    NavTab.my: const MyFeedScreen(),
  };

  final bool showTooltip = false;

  static const storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthToken();
    });
    var argTab = Get.arguments == null ? null : Get.arguments['tab'];

    if (_allowedRoutes.contains(argTab)) {
      _currentTab = argTab;
    }

    WidgetsBinding.instance.addObserver(this);
  }

  void _checkAuthToken() async {
    if (Config.isLocal) return;
    try {
      String? value = await storage.read(key: 'authToken');
      if (value == null) {
        Get.offAllNamed('/login');
      }
    } catch (e) {}
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
          width: 32,
          colorFilter:
              const ColorFilter.mode(Color(0xFFBFC9D0), BlendMode.srcIn),
        ),
        label: label);
  }

  AppBarLeft _getAppBarLeft() {
    if (_currentTab == NavTab.home) {
      return AppBarLeft(iconType: LeftIconType.LOGO);
    }
    if (_currentTab == NavTab.feed) return AppBarLeft(label: '산책피드');
    return AppBarLeft(label: '내 일지');
  }

  @override
  Widget build(BuildContext context) {
    var labelStyle = const TextStyle(
        fontWeight: FontWeight.w600, fontSize: 11, letterSpacing: -0.01 * 11);

    return Scaffold(
      appBar: SharedAppBar(
        leftOptions: _getAppBarLeft(),
        rightOptions: AppBarRight(icons: [
          RightIcon(
              name: _currentTab == NavTab.feed ? 'friend' : 'calendar',
              onTap: () => {
                    Get.toNamed(_currentTab == NavTab.feed
                        ? '/friends/code'
                        : '/calendar')
                  }),
          RightIcon(name: 'setting', onTap: () => {Get.toNamed('/settings')})
        ]),
      ),
      body: _pages[_currentTab],
      floatingActionButton:
          _currentTab == NavTab.home ? null : const WriteFloatingButton(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(20), right: Radius.circular(20)),
            border: Border.all(color: ThemeColor.gray2, width: 1)),
        child: ClipRRect(
          borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(20), right: Radius.circular(20)),
          child: BottomNavigationBar(
            currentIndex: _allowedRoutes.indexOf(_currentTab),
            onTap: (index) => _changeTab(index),
            selectedItemColor: ThemeColor.gray6,
            selectedLabelStyle: labelStyle,
            unselectedItemColor: ThemeColor.gray4,
            unselectedLabelStyle: labelStyle,
            items: [
              _createBottomNavigationBarItem('feed', '산책피드'),
              _createBottomNavigationBarItem('home', '홈'),
              _createBottomNavigationBarItem('diary', '내 일지'),
            ],
          ),
        ),
      ),
    );
  }
}

class WriteFloatingButton extends StatefulWidget {
  const WriteFloatingButton({
    super.key,
  });

  @override
  State<WriteFloatingButton> createState() => _WriteFloatingButtonState();
}

class _WriteFloatingButtonState extends State<WriteFloatingButton> {
  final userController = Get.find<UserController>();
  final ImagePicker picker = ImagePicker();
  late bool showTooltip = false;

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      Get.toNamed('/create', arguments: {
        'photoPath': pickedFile.path,
        'from': NavTab.feed.toString()
      });
    }
  }

  _onButtonClick(bool hasWritten) {
    if (hasWritten) {
      if (!showTooltip) {
        setState(() {
          showTooltip = true;
          Future.delayed(const Duration(seconds: 1), () {
            showTooltip = false;
            setState(() {});
          });
        });
      }
      return;
    }
    getImage(ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    var hasWritten = userController.user.value!.walkDone;
    var floatingButtonColor =
        Theme.of(context).floatingActionButtonTheme.backgroundColor;

    return Container(
      margin: const EdgeInsets.only(right: 4),
      width: 155,
      height: 117,
      decoration: const BoxDecoration(),
      child: Stack(
        fit: StackFit.loose,
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      color: ThemeColor.black.withOpacity(0.13),
                      blurRadius: 30,
                      offset: const Offset(0, 2),
                      spreadRadius: 0),
                ],
              ),
              child: FloatingActionButton(
                elevation: 0,
                onPressed: () => {_onButtonClick(hasWritten)},
                backgroundColor:
                    hasWritten == true ? ThemeColor.gray3 : floatingButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: SvgPicture.asset(
                  'assets/icons/write.svg',
                  colorFilter: hasWritten
                      ? ColorFilter.mode(ThemeColor.gray2, BlendMode.srcIn)
                      : null,
                  width: 32,
                ),
              ),
            ),
          ),
          if (showTooltip)
            Positioned(
                right: 0,
                child: Container(
                  height: 38,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: ThemeColor.gray6,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Body4(
                      value: '이미 산책을 완료했어요!',
                      color: ThemeColor.white,
                      fontWeight: FontWeight.w600),
                )),
          if (showTooltip)
            Positioned(
              top: 38,
              right: 32,
              child: CustomPaint(
                painter: SpeechBubblePainter(),
              ),
            )
        ],
      ),
    );
  }
}

class SpeechBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = ThemeColor.gray6
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path.lineTo(-7, 0);
    path.lineTo(0, 8);
    path.lineTo(7, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(SpeechBubblePainter oldDelegate) {
    return false;
  }
}
