import 'package:flutter/material.dart';
import 'package:share/share.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  String code = 'agn35gk94';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '내 정보',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ), // 왼쪽 정렬이 완벽하게 안됨 어케함쇼
        centerTitle: false,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Center(
            child: Column(
              children: [
                Container(
                  height: 128,
                  width: 128,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(100)),
                ),
                Transform.translate(
                  offset: const Offset(40, -35),
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    onPressed: () => {},
                    mini: true,
                    child: const Icon(Icons.add),
                  ),
                ),
                const Text(
                  '앙꼬',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                TextButton(
                  onPressed: () => {Share.share(code)},
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.grey)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '@$code',
                      ),
                      const Icon(Icons.share_rounded)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 8,
                  decoration: const BoxDecoration(color: Colors.grey),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
