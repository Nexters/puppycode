import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isAlarmEnabled = true;
  String time = DateFormat.jm().format(DateTime.now());

  void onSwitchPressed(value) {
    setState(() {
      isAlarmEnabled = value;
    });
  }

  DateTime _parseTime(String time) {
    final now = DateTime.now();
    final format = DateFormat.jm();
    final DateTime date = format.parse(time);

    return DateTime(now.year, now.month, now.day, date.hour, date.minute);
  }

  void onSetTime() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 213,
                width: 198,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white),
                child: CupertinoDatePicker(
                  //use24hFormat: true,
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: _parseTime(time),
                  onDateTimeChanged: (DateTime date) {
                    setState(() {
                      time = DateFormat.jm().format(date);
                    });
                  },
                ),
              ),
            ),
          ],
        );
      },
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              const SettingList(lists: [
                SettingListItem(
                  title: '내 프로필',
                  icon: Icons.info_outline,
                  destination: '/settings/userInfo',
                  widget: Icon(
                    color: Color.fromRGBO(128, 128, 128, 0.55),
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ),
                SettingListItem(
                  title: '친구리스트',
                  icon: Icons.person,
                  destination: '/settings/friends',
                  widget: Icon(
                    color: Color.fromRGBO(128, 128, 128, 0.55),
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ),
              ], title: '내 정보'),
              SettingList(lists: [
                SettingListItem(
                  title: '알림',
                  icon: Icons.notifications,
                  destination: '',
                  widget: CupertinoSwitch(
                    value: isAlarmEnabled,
                    onChanged: onSwitchPressed,
                  ),
                ),
                SettingListItem(
                  title: '알람시간 설정',
                  icon: Icons.timer,
                  destination: '',
                  widget: TextButton(
                    onPressed: isAlarmEnabled == false ? null : onSetTime,
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        backgroundColor:
                            const Color.fromRGBO(120, 120, 128, 0.12)),
                    child: Text(
                      time,
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ], title: '알림'),
              const SettingList(lists: [
                SettingListItem(
                  title: '앱 정보',
                  icon: Icons.info_rounded,
                  destination: '',
                  widget: Text(
                    '현재 버전 1.0.0',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                ),
                SettingListItem(
                  title: '계정정보',
                  icon: Icons.person,
                  destination: '',
                  widget: null,
                ),
                SettingListItem(
                  title: '이용약관',
                  icon: Icons.link,
                  destination: '',
                  widget: null,
                ),
                SettingListItem(
                  title: '개인정보 처리방침',
                  icon: Icons.person,
                  destination: '',
                  widget: null,
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 0, 0, 0.03),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: lists,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingListItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? destination;
  final Widget? widget;

  const SettingListItem({
    super.key,
    required this.title,
    required this.icon,
    required this.widget,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
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
                Icon(icon),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              child: widget,
            )
          ],
        ),
      ),
    );
  }
}
