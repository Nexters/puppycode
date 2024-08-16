import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/banner.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class FriendsListPage extends StatefulWidget {
  const FriendsListPage({super.key});

  @override
  State<FriendsListPage> createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  bool hasFriends = false; // 임시 bool, api 연결 후에 리팩

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SharedAppBar(
        leftOptions: AppBarLeft(iconType: LeftIconType.BACK),
        centerOptions: AppBarCenter(label: '친구 목록'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Column(
              children: [
                SharedBanner(
                  mainText: '친구 코드 입력하기',
                  subText: '함께 산책 공유할 친구를 추가해 보세요',
                  iconName: 'code',
                  onClick: () => {
                    Get.toNamed('/friends/code'),
                  },
                ),
              ],
            ),
          ),
          hasFriends
              ? const Padding(
                  padding: EdgeInsets.fromLTRB(20, 18, 20, 0),
                  child: Column(
                    children: [
                      FriendsList(
                        userName: '푸름이',
                      ),
                      FriendsList(
                        userName: '똥개',
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Image.asset('assets/images/friends_empty.png'),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 100), // 이렇게 되네.. ㅋㅋㅋ
                          child: Body2(
                            value: '친구를 기다리고 있어요!',
                            color: ThemeColor.gray3,
                            bold: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class FriendsList extends StatelessWidget {
  final String userName;

  const FriendsList({
    //profile 사진
    required this.userName,
    super.key,
  });

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              actions: <CupertinoActionSheetAction>[
                CupertinoActionSheetAction(
                  onPressed: () {
                    Get.back();
                  },
                  isDestructiveAction: true,
                  child: Body2(value: '신고하기', color: ThemeColor.error),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    Get.back();
                  },
                  isDestructiveAction: true,
                  child: Body2(value: '친구끊기', color: ThemeColor.error),
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Get.back();
                },
                child: Body2(value: '취소하기', color: ThemeColor.blue),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              badges.Badge(
                position: badges.BadgePosition.bottomEnd(bottom: -4, end: -3),
                badgeContent: SvgPicture.asset('assets/icons/foot_print.svg'),
                badgeStyle: badges.BadgeStyle(
                    badgeColor: ThemeColor.white,
                    padding: const EdgeInsets.all(1)),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 63, 113, 163),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 48,
                  width: 48,
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Body1(value: userName, bold: true),
            ],
          ),
          IconButton(
            onPressed: () {
              _showActionSheet(context);
            },
            icon: SvgPicture.asset(
              'assets/icons/details.svg',
              colorFilter: ColorFilter.mode(ThemeColor.gray4, BlendMode.srcIn),
              height: 24,
              width: 24,
            ),
          )
        ],
      ),
    );
  }
}
