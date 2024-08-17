import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:puppycode/apis/models/friends.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/banner.dart';
import 'package:puppycode/shared/http.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class FriendsListPage extends StatefulWidget {
  const FriendsListPage({super.key});

  @override
  State<FriendsListPage> createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  List<Friend>? friendList;

  @override
  void initState() {
    _fetchFriends();
    super.initState();
  }

  Future<void> _fetchFriends() async {
    try {
      final items =
          await HttpService.get('friends', params: {'sort': 'FRIEND_DESC'});
      List<Friend> friends = items.map((item) => Friend(item)).toList();

      setState(() {
        friendList = friends;
      });

      print(friendList![0].profileUrl);
    } catch (error) {
      print(error);
    }
  }

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
          friendList != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                  child: Column(
                    children: [
                      for (var friend in friendList!)
                        FriendsList(
                          userName: friend.name,
                          profileImageUrl: friend.profileUrl,
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
  final String profileImageUrl;

  const FriendsList({
    required this.userName,
    required this.profileImageUrl,
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                      height: 48,
                      width: 48,
                      child: Image.network(profileImageUrl)),
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
