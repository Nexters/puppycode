import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:puppycode/pages/setting/time_button.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/caption.dart';
import 'package:puppycode/shared/typography/head.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isRoutineNotificationEnabled = true; // 산책 루틴 알림
  bool isPushNotificationEnabled = false; // 찌르기 알림
  String time = DateFormat.jm().format(DateTime.now());
  GlobalKey buttonKey = GlobalKey();

  void onRoutineNotificationSwitchPressed(value) {
    // 이렇게 길어도 갠차나염 ..? 🥲
    setState(() {
      isRoutineNotificationEnabled = value;
    });
  }

  void onPushNotificationSwitchPressed(value) {
    setState(() {
      isPushNotificationEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SharedAppBar(
        leftOptions: AppBarLeft(),
        centerOptions: AppBarCenter(label: '설정'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                  destination: '',
                  widget: SizedBox(
                      height: 34,
                      child: SetWalkTimeButton(
                          buttonKey: buttonKey,
                          time: time,
                          buttonEnabled: isRoutineNotificationEnabled)),
                ),
                SettingListItem(
                  title: '산책 루틴 알림',
                  subTitle: '지정한 산책 시간에 알림을 받을 수 있어요',
                  destination: '',
                  widget: SizedBox(
                    width: 52,
                    height: 30,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: CupertinoSwitch(
                        value: isRoutineNotificationEnabled,
                        activeColor: ThemeColor.primary,
                        onChanged: onRoutineNotificationSwitchPressed,
                      ),
                    ),
                  ),
                ),
                SettingListItem(
                  title: '찌르기 알림',
                  destination: '',
                  widget: SizedBox(
                    width: 52,
                    height: 30,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: CupertinoSwitch(
                        value: isPushNotificationEnabled,
                        activeColor: ThemeColor.primary,
                        onChanged: onPushNotificationSwitchPressed,
                      ),
                    ),
                  ),
                ),
              ], title: '알림'),
              SettingList(lists: [
                SettingListItem(
                  title: '앱 정보',
                  destination: '',
                  widget: Body3(value: '현재 버전 1.0.0', color: ThemeColor.gray4),
                ),
                const SettingListItem(
                  title: '계정정보',
                  destination: '',
                ),
                const SettingListItem(
                  title: '이용약관',
                  destination: '',
                ),
                const SettingListItem(
                  title: '개인정보 처리방침',
                  destination: '',
                ),
              ], title: '도움말'),
            ],
          ),
        ),
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
          Head4(value: title),
          const SizedBox(
            height: 12,
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

  const SettingListItem({
    super.key,
    required this.title,
    this.subTitle,
    this.widget,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (destination != '') Get.toNamed(destination!);
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
                        child:
                            Caption(value: subTitle!, color: ThemeColor.gray4),
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
                  ), // 기본값으로 SvgPicture 사용
            ),
          ],
        ),
      ),
    );
  }
}
