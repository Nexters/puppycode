import 'package:flutter/material.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class FeedEmpty extends StatelessWidget {
  const FeedEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 66),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset('assets/images/empty.png', width: 140),
          Body2(
            value: '피드가 텅 비어 있어요.',
            color: ThemeColor.gray3,
            bold: true,
          )
        ],
      ),
    );
  }
}
