import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puppycode/pages/home.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool switchValue = true;

  void onSwitchPressed(value) {
    setState(() {
      switchValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              ListWidget(lists: [
                SettingLists(
                  title: '내 정보',
                  icon: Icons.info_outline,
                  widget: GestureDetector(
                    onTap: () {
                      Get.to(() => HomePage());
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  ),
                ),
                const SettingLists(
                  title: '내 초대링크',
                  icon: Icons.link,
                  widget: null,
                ),
                SettingLists(
                  title: '친구리스트',
                  icon: Icons.person,
                  widget: GestureDetector(
                    onTap: () {
                      Get.to(() => HomePage());
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  ),
                ),
              ], title: '내 정보'),
              ListWidget(lists: [
                SettingLists(
                  title: '알림',
                  icon: Icons.notifications,
                  widget: CupertinoSwitch(
                    value: switchValue,
                    onChanged: onSwitchPressed,
                  ),
                ),
                const SettingLists(
                  title: '시간설정',
                  icon: Icons.timer,
                  widget: Text(
                    '00:00',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ], title: '알림'),
              const ListWidget(lists: [
                SettingLists(
                  title: '앱 정보',
                  icon: Icons.info_rounded,
                  widget: Text(
                    '현재 버전 1.0.0',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                ),
                SettingLists(
                  title: '이용약관',
                  icon: Icons.link,
                  widget: null,
                ),
                SettingLists(
                  title: '개인정보 처리방침',
                  icon: Icons.person,
                  widget: null,
                ),
                SettingLists(
                  title: '계정관리',
                  icon: Icons.person,
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

class ListWidget extends StatelessWidget {
  final List<SettingLists> lists;
  final String title;

  const ListWidget({
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

class SettingLists extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? widget;

  const SettingLists({
    super.key,
    required this.title,
    required this.icon,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
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
    );
  }
}
