import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:puppycode/apis/models/friends.dart';
import 'package:puppycode/shared/banner.dart';
import 'package:puppycode/shared/image.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/toast.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/http.dart';
import 'package:puppycode/shared/states/user.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FeedFriends extends StatefulWidget {
  const FeedFriends({
    super.key,
    required this.onSelect,
    this.focusedUserId,
  });

  final void Function(int?) onSelect;
  final int? focusedUserId;

  @override
  State<FeedFriends> createState() => _FeedFriendsState();
}

class _FeedFriendsState extends State<FeedFriends> {
  List<Friend> friendList = [];
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    _fetch();
    super.initState();
  }

  Future<void> _fetch() async {
    try {
      final items = await HttpService.get('friends', params: {
        'sort': 'WALK_DONE_DESC',
      });
      List<Friend> friends = items.map((item) => Friend(item)).toList();

      setState(() {
        friendList = friends;
      });
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    final user = userController.user.value;

    if (user == null) return const CupertinoActivityIndicator();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (friendList.isEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SharedBanner(
                  mainText: '친구를 찾아 떠나볼까요?',
                  subText: '친구와 함께 강아지의 일상을 공유해 보아요!',
                  iconName: 'friends',
                  onClick: () {
                    analytics.logEvent(name: 'exploreFriends');
                    Get.toNamed('/friends/code');
                  }),
            ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FeedUserStatus(
                    id: user.id,
                    name: user.nickname,
                    hasWalked: user.walkDone,
                    isMine: true,
                    profileImageUrl: user.profileImageUrl,
                    focusedUserId: widget.focusedUserId,
                    onClick: (int? id) => {widget.onSelect(null)},
                  ),
                  ...friendList.map((friend) => FeedUserStatus(
                        id: friend.id,
                        name: friend.name,
                        hasWalked: friend.hasWalked,
                        profileImageUrl: friend.profileUrl,
                        focusedUserId: widget.focusedUserId,
                        onClick: widget.onSelect,
                      )),
                ],
              )),
        ],
      ),
    );
  }
}

class FeedUserStatus extends StatelessWidget {
  const FeedUserStatus({
    super.key,
    required this.id,
    required this.name,
    required this.hasWalked,
    required this.onClick,
    required this.profileImageUrl,
    this.focusedUserId,
    this.isLast = false,
    this.isMine = false,
  });

  final int id;
  final String name;
  final bool hasWalked;
  final String profileImageUrl;
  final bool isLast;
  final void Function(int?) onClick;

  final int? focusedUserId;
  final bool isMine;

  _onFriendClick(BuildContext context) {
    if (hasWalked || isMine) return;
    try {
      Toast.show(context, '$name에게 찌르기 알림을 보냈어요');
      HttpService.post('push/users/$id', body: {});
    } on FormatException {
      // ignore
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    var isOtherUserFocused = focusedUserId != null && focusedUserId != id;
    var isMeFocused = focusedUserId != null && focusedUserId == id;

    var isDimmed = isOtherUserFocused || (!isMeFocused && !hasWalked);
    var nameColor = isDimmed ? ThemeColor.gray3 : ThemeColor.gray6;

    return GestureDetector(
      onTap: () => {onClick(id)},
      child: Container(
        width: 48,
        margin: EdgeInsets.only(right: isLast ? 0 : 12),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: ThemeColor.gray2,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: UserNetworkImage(
                        url: profileImageUrl,
                        isDimmed: isDimmed,
                      )),
                ),
                if (isMine)
                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.center,
                        child: Body4(
                          value: '나',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          textShadow: Shadow(
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        )),
                  ),
                if (!isMine || hasWalked)
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => {_onFriendClick(context)},
                        child: FeedFriendIcon(hasWalked: hasWalked),
                      ))
              ],
            ),
            const SizedBox(height: 4),
            Body4(
              value: name,
              color: nameColor,
              fontWeight: isMeFocused ? FontWeight.w600 : FontWeight.w400,
              maxLine: 1,
            )
          ],
        ),
      ),
    );
  }
}

class FeedFriendIcon extends StatelessWidget {
  FeedFriendIcon({
    super.key,
    required this.hasWalked,
  });

  final bool hasWalked;
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        boxShadow: hasWalked
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.13),
                  blurRadius: 9,
                  offset: const Offset(0, 1.13),
                )
              ],
        shape: BoxShape.circle,
      ),
      child: GestureDetector(
        child: SvgPicture.asset(
            hasWalked ? 'assets/icons/paw_small.svg' : 'assets/icons/push.svg',
            width: 22),
        onTap: () {
          if (!hasWalked) {
            analytics.logEvent(name: 'send-push');
          }
        },
      ),
    );
  }
}
