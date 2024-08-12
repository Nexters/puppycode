import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:puppycode/pages/feeds/feed_friends.dart';
import 'package:puppycode/pages/feeds/feed_scroll.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FeedFriends(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            width: MediaQuery.of(context).size.width,
            child: const FeedListView(),
          )
        ],
      ),
    );
  }
}
