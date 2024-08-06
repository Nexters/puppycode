import 'package:flutter/material.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';

class Feed {
  Feed({required this.id, required this.name, this.title});

  final String id;
  final String name;
  final String? title;
}

class FeedItem extends StatefulWidget {
  const FeedItem({
    super.key,
    required this.item,
  });

  final Feed item;

  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  late FocusNode focusNode;

  Color overlayColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      _changeOverlayColor(focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  _changeOverlayColor(bool hasFocus) {
    setState(() {
      overlayColor = hasFocus
          ? Colors.black.withOpacity(0.6)
          : Colors.black.withOpacity(0.3);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = (MediaQuery.of(context).size.width - 40) * 1.33;
    final name = widget.item.name;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: height,
      decoration: BoxDecoration(
          color: overlayColor, borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: <Widget>[
          NameLabel(name: name),
          const Positioned(
              top: 58,
              left: 16,
              child: Head3(
                value: '자다가 산책가자니까 벌떡 일어나는거봐',
                color: Colors.white,
              )),
        ],
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
    return Positioned(
        top: 20,
        left: 16,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
          decoration: BoxDecoration(
              color: const Color(0x14FFFFFF),
              borderRadius: BorderRadius.circular(20)),
          child: Body4(
            value: name,
            color: Colors.white,
          ),
        ));
  }
}
