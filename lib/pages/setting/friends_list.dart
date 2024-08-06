import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/typography.dart';

class FriendsListPage extends StatefulWidget {
  const FriendsListPage({super.key});

  @override
  State<FriendsListPage> createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  bool hasFriends = true; // 임시 bool, api 연결 후에 리팩

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '친구 리스트',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                    ),
                  ]),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.toNamed('/friends/code');
                },
                child: const Padding(
                  padding: EdgeInsets.all(
                    12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.qr_code_2,
                            size: 48,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Body2(
                                value: '친구 코드 입력하기',
                                bold: true,
                              ),
                              Body4(value: '함께 산책 공유할 친구를 추가해 보세요'),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            ),
            hasFriends
                ? const Column(
                    children: [
                      SizedBox(
                        height: 27,
                      ),
                      FriendsList(
                        userName: '푸름이',
                      ),
                      FriendsList(
                        userName: '똥개',
                      ),
                    ],
                  )
                : Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 162, 162, 162),
                            ),
                            height: 128,
                            width: 128,
                            child: const Center(
                              child: Text('graphic'),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Body4(value: '우리집 강아지 친구 찾으러 갈까요?', bold: true)
                        ],
                      ),
                    ),
                  )
          ],
        ),
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
                      Navigator.pop(context);
                    },
                    isDestructiveAction: true,
                    child: const Text(
                      '신고하기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    isDestructiveAction: true,
                    child: const Text(
                      '친구끊기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  '취소하기',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              badges.Badge(
                position: badges.BadgePosition.bottomEnd(
                  bottom: 0,
                  end: 0,
                ),
                badgeContent: const Icon(
                  Icons.person,
                  size: 12,
                  color: Color.fromRGBO(54, 219, 191, 1.0),
                ),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Color.fromRGBO(239, 242, 245, 1),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(239, 242, 245, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 48,
                  width: 48,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                userName,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              _showActionSheet(context);
            },
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
    );
  }
}
