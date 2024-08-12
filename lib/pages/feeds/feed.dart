import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:puppycode/pages/feeds/feed_friends.dart';
import 'package:puppycode/pages/feeds/feed_scroll.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
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
        FeedFriends(
          onSelect: setFocusUser,
          focusedUserId: focusedUserId,
        ),
        Expanded(
          child: Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: const FeedListView()),
        )
      ],
    );
  }
}
