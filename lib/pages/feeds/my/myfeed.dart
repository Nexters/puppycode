import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:puppycode/pages/feeds/my/myfeed_scroll.dart';

class MyFeedScreen extends StatefulWidget {
  const MyFeedScreen({super.key});

  @override
  State<MyFeedScreen> createState() => _MyFeedScreenState();
}

class _MyFeedScreenState extends State<MyFeedScreen> {
  String? focusedUserId;

  void setFocusUser(String? userId) {
    setState(() {
      focusedUserId = focusedUserId == userId ? null : userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: const MyFeedGridView()),
        )
      ],
    );
  }
}
