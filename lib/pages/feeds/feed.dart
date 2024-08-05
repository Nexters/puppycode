import 'package:flutter/material.dart';
import 'package:puppycode/pages/feeds/feed_friends.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Column(
        children: [FeedFriends()],
      ),
    );
  }
}
