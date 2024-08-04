import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:badges/badges.dart' as badges;

class FriendsListPage extends StatefulWidget {
  const FriendsListPage({super.key});

  @override
  State<FriendsListPage> createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
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
      body: SingleChildScrollView(
        child: Padding(
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
                                Text(
                                  '친구 코드 입력하기',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '함께 산책 공유할 친구를 추가해 보세요',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
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
              const SizedBox(
                height: 27,
              ),
              const FriendsList(
                userName: '푸름이',
              ),
              const FriendsList(
                userName: '똥개',
              )
              // Todo: 친구 리스트 컴포 빼기
            ],
          ),
        ),
      ),
    );
  }
}

class FriendsList extends StatelessWidget {
  //   final List<SettingListItem> lists;
  // final String title;

  // const SettingList({
  //   super.key,
  //   required this.lists,
  //   required this.title,
  // });

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
                    child: const Text(
                      '신고하기',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      '친구끊기',
                      style: TextStyle(
                        color: Colors.red,
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
