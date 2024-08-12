import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:puppycode/pages/feeds/feed_friends.dart';
import 'package:puppycode/pages/feeds/feed_scroll.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FeedFriends(),
          Expanded(
            child: Container(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: const FeedListView()),
          )
        ],
      ),
    );
  }
}
