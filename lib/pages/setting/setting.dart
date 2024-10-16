import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:puppycode/pages/setting/time_button.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/http.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/caption.dart';
import 'package:puppycode/shared/typography/head.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isWalkNotificationEnabled = true; // 산책 루틴 알림
  //bool isPushNotificationEnabled = false; // 찌르기 알림
  String walkTime = '';
  late Future<void> _fetchFuture;

  @override
  void initState() {
    super.initState();
    _fetchFuture = _fetchPushNotificationTime();
  }

  static const String url =
      'https://talented-volleyball-aaf.notion.site/539274c7d2884431a4321454cac2e39b?pvs=4';

  void onWalkNotificationSwitched(bool value) {
    setState(() {
      isWalkNotificationEnabled = value;
    });

    _setWalkNotificationAlert(walkTime);
  }

  Future<void> _fetchPushNotificationTime() async {
    try {
      final res = await HttpService.getOne('users/push-notification');

      setState(() {
        walkTime = res['pushNotificationTime'].toString();
        isWalkNotificationEnabled = res['on'];
      });
    } catch (err) {}
  }

  Future<void> _setWalkNotificationAlert(newWalkTime) async {
    try {
      await HttpService.patch('users/push-notification', params: {
        'time': newWalkTime,
        'isOn': isWalkNotificationEnabled.toString()
      });
    } catch (err) {}
  }

  // void onPushNotificationSwitched(value) {
  //   setState(() {
  //     isPushNotificationEnabled = value;
  //   });
  // }

  Future<void> _launchUrl() async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SharedAppBar(
        leftOptions: AppBarLeft(),
        centerOptions: AppBarCenter(label: '설정'),
      ),
      body: FutureBuilder(
        future: _fetchFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(color: ThemeColor.primary));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  children: [
                    const SettingList(lists: [
                      SettingListItem(
                        title: '내 프로필',
                        destination: '/settings/userInfo',
                      ),
                      SettingListItem(
                        title: '친구 목록',
                        destination: '/friends',
                      ),
                    ], title: '내 정보'),
                    SettingList(lists: [
                      SettingListItem(
                        title: '산책 시간 설정',
                        widget: SizedBox(
                          height: 34,
                          child: SetWalkTimeButton(
                            walkTime: walkTime,
                            notificationEnabled: isWalkNotificationEnabled,
                          ),
                        ),
                      ),
                      SettingListItem(
                          title: '산책 루틴 알림',
                          subTitle: '지정한 산책 시간에 알림을 받을 수 있어요',
                          widget: CustomCupertinoSwitch(
                            onPressed: onWalkNotificationSwitched,
                            isNotificationEnabled: isWalkNotificationEnabled,
                          )),
                      // SettingListItem(
                      //   title: '찌르기 알림',
                      //   widget: CustomCupertinoSwitch(
                      //     onPressed: onPushNotificationSwitched,
                      //     isNotificationEnabled: isPushNotificationEnabled,
                      //   ),
                      // ),
                    ], title: '알림'),
                    SettingList(lists: [
                      SettingListItem(
                        title: '앱 정보',
                        widget: Body3(
                            value: '현재 버전 1.0.1', color: ThemeColor.gray4),
                      ),
                      const SettingListItem(
                        title: '이용약관',
                      ),
                      SettingListItem(
                          title: '개인정보 처리방침',
                          onTab: () {
                            _launchUrl();
                          }),
                    ], title: '도움말'),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class SettingList extends StatelessWidget {
  final List<SettingListItem> lists;
  final String title;

  const SettingList({
    super.key,
    required this.lists,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Column(
              children: [
                Head4(value: title),
                const SizedBox(
                  height: 12,
                )
              ],
            ),
          Column(
            children: lists,
          ),
        ],
      ),
    );
  }
}

class SettingListItem extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String? destination;
  final Widget? widget;
  final VoidCallback? onTab;

  const SettingListItem({
    super.key,
    required this.title,
    this.subTitle,
    this.widget,
    this.destination,
    this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (onTab != null) {
            onTab!();
          }
          if (destination != null) Get.toNamed(destination!);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Body1(value: title, color: ThemeColor.gray5),
                    if (subTitle != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Caption(value: subTitle!),
                      ),
                  ],
                ),
              ],
            ),
            SizedBox(
              child: widget ??
                  SvgPicture.asset(
                    'assets/icons/chevron_right.svg',
                    colorFilter:
                        ColorFilter.mode(ThemeColor.gray3, BlendMode.srcIn),
                    width: 20,
                    height: 20,
                  ), // 기본값으로 SvgPicture 사용
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCupertinoSwitch extends StatefulWidget {
  const CustomCupertinoSwitch({
    super.key,
    required this.onPressed,
    required this.isNotificationEnabled,
  });

  final void Function(bool) onPressed;
  final bool isNotificationEnabled;

  @override
  State<CustomCupertinoSwitch> createState() => _CustomCupertinoSwitchState();
}

class _CustomCupertinoSwitchState extends State<CustomCupertinoSwitch> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 32,
      child: FittedBox(
        fit: BoxFit.contain,
        child: CupertinoSwitch(
          value: widget.isNotificationEnabled,
          activeColor: ThemeColor.primary,
          onChanged: (value) {
            widget.onPressed(value);
          },
        ),
      ),
    );
  }
}
