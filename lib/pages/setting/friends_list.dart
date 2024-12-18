import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:puppycode/apis/models/friends.dart';
import 'package:puppycode/pages/feeds/feed_friends.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/banner.dart';
import 'package:puppycode/shared/function/sharedAlertDialog.dart';
import 'package:puppycode/shared/http.dart';
import 'package:puppycode/shared/image.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/toast.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FriendsListPage extends StatefulWidget {
  const FriendsListPage({super.key});

  @override
  State<FriendsListPage> createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  List<Friend>? friendList;
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

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
    } catch (error) {}
  }

  Future<void> _deleteFriend(int friendUserId) async {
    try {
      await HttpService.delete('friends/$friendUserId');
      _fetchFriends();
    } catch (error) {}
  }

  Future<void> _reportFriend(context, reportUserId, reason) async {
    try {
      await HttpService.post('users/report',
              body: {'reportedUserId': reportUserId, 'reason': reason})
          .then((_) => {Toast.show(context, '신고를 완료했어요')});
    } catch (err) {}
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
                  onClick: () async {
                    analytics.logEvent(
                        name: 'AddFriends', parameters: {'reason': 'banner'});
                    final result = await Get.toNamed('/friends/code');
                    if (result == true) {
                      _fetchFriends();
                    }
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
                        FriendItem(
                          userName: friend.name,
                          profileImageUrl: friend.profileUrl,
                          hasWalked: friend.hasWalked,
                          onDelete: () {
                            _deleteFriend(friend.id);
                          },
                          onReport: () {
                            _reportFriend(context, friend.id, '욕설');
                          },
                        ),
                    ],
                  ),
                )
              : Expanded(
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Body2(
                          value: '친구를 기다리고 있어요!',
                          color: ThemeColor.gray3,
                          bold: true,
                        ),
                        const SizedBox(height: 48),
                        Container(
                          alignment: Alignment.bottomRight,
                          padding: const EdgeInsets.only(bottom: 48),
                          child: Image.asset(
                            'assets/images/friends_nothing.png',
                            width: 180,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class FriendItem extends StatelessWidget {
  final String userName;
  final String profileImageUrl;
  final VoidCallback onDelete;
  final VoidCallback onReport;
  final bool hasWalked;

  const FriendItem({
    required this.userName,
    required this.profileImageUrl,
    required this.onDelete,
    required this.hasWalked,
    super.key,
    required this.onReport,
  });

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              actions: <CupertinoActionSheetAction>[
                CupertinoActionSheetAction(
                  onPressed: () {
                    Get.back();
                    onReport();
                    // TODO: toast 유저 신고
                  },
                  isDestructiveAction: true,
                  child: Body2(value: '신고하기', color: ThemeColor.error),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    Get.back();
                    showSharedDialog(
                      context,
                      AlertDialogType.DELFRIEND,
                      () {
                        onDelete();
                      },
                    );
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
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: UserNetworkImage(url: profileImageUrl),
                    ),
                  ),
                  if (hasWalked)
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: FeedFriendIcon(
                          hasWalked: true,
                        )),
                ],
              ),
              const SizedBox(
                width: 14,
              ),
              Body1(value: userName, bold: true, maxLength: 10),
            ],
          ),
          GestureDetector(
            onTap: () {
              _showActionSheet(context);
            },
            child: SvgPicture.asset(
              'assets/icons/more.svg',
              colorFilter: ColorFilter.mode(ThemeColor.gray4, BlendMode.srcIn),
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
    );
  }
}
