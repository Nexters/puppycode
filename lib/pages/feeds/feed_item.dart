import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';

class Feed {
  Feed(dynamic logItem) {
    id = logItem['id'];
    photoUrl = logItem['photoUrl'];
    name = logItem['writerNickname'] ?? 'unknown';
    title = logItem['title'];
    episode = logItem['content'];
    profileUrl = logItem['writerProfileUrl'];
  }

  late int id;
  late String photoUrl;
  late String name;
  String? title;
  String? episode;
  String? profileUrl;
}

class FeedItem extends StatefulWidget {
  const FeedItem({
    super.key,
    required this.item,
    required this.isListView,
  });

  final Feed item;
  final bool isListView;

  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  late Feed feed;

  Color overlayColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    feed = widget.item;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = widget.isListView
        ? (MediaQuery.of(context).size.width - 40)
        : (MediaQuery.of(context).size.width - 40 - 10) / 2;
    var height = width * 1.33;

    return GestureDetector(
      onTap: () {
        Get.toNamed('/feed/1');
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: widget.isListView ? const EdgeInsets.only(bottom: 20) : null,
        height: height,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: <Widget>[
            FeedPhoto(isListView: widget.isListView, photoUrl: feed.photoUrl),
            if (widget.isListView)
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0),
                        ],
                        stops: const [
                          0,
                          0.4
                        ])),
              ),
            Positioned(
                top: height * 0.0421,
                left: width * 0.0457,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.isListView) NameLabel(name: feed.name),
                    const SizedBox(height: 8),
                    if (widget.isListView && feed.title != null)
                      Head3(
                        value: feed.title!,
                        color: Colors.white,
                      )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class FeedPhoto extends StatelessWidget {
  const FeedPhoto({super.key, this.isListView, this.photoUrl});
  final bool? isListView;
  final String? photoUrl; // my feed 수정하고 required로

  @override
  Widget build(BuildContext context) {
    var width = isListView == false
        ? (MediaQuery.of(context).size.width - 40 - 10) / 2
        : (MediaQuery.of(context).size.width - 40);
    var height = width * 1.33;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        photoUrl ??
            'https://dispatch.cdnser.be/wp-content/uploads/2018/09/eb93160db25faf9577d57c2f308e8c18.png', // TODO: errorBuilder
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
    );
  }
}

class NameLabel extends StatelessWidget {
  const NameLabel({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
      decoration: BoxDecoration(
          color: ThemeColor.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20)),
      child: Body4(
        value: name,
        fontWeight: FontWeight.w600,
        color: ThemeColor.white,
      ),
    );
  }
}
