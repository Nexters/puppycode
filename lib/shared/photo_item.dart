import 'package:flutter/material.dart';
import 'package:puppycode/shared/typography/head.dart';

class PhotoItem extends StatelessWidget {
  const PhotoItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: (MediaQuery.of(context).size.width - 40) * 1.33,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration:
                        const InputDecoration(
                        hintText: '개떡아 오늘 산책은 어땠어?',
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.4))),
                    style: HeadTextStyle.getH3Style(color: Colors.white),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
