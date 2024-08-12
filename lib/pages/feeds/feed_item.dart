import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/styles/color.dart';
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
    var width = (MediaQuery.of(context).size.width - 40);
    var height = width * 1.33;
    final name = widget.item.name;

    return GestureDetector(
      onTap: () {
        Get.toNamed('/myfeed');
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: height,
        decoration: BoxDecoration(
            color: overlayColor, borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: <Widget>[
            const FeedPhoto(),
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
                    NameLabel(name: name),
                    const SizedBox(height: 8),
                    const Head3(
                  value: '자다가 산책가자니까 벌떡 일어나는거봐',
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
  const FeedPhoto({super.key});


  @override
  Widget build(BuildContext context) {
    var width = (MediaQuery.of(context).size.width - 40);
    var height = width * 1.33;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        'https://dispatch.cdnser.be/wp-content/uploads/2018/09/eb93160db25faf9577d57c2f308e8c18.png',
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
