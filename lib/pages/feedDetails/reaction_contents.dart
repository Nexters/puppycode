import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/caption.dart';

class ReactionContents extends StatefulWidget {
  const ReactionContents({super.key});

  @override
  State<ReactionContents> createState() => _ReactionContentsState();
}

class _ReactionContentsState extends State<ReactionContents> {
  GlobalKey emojiKey = GlobalKey();

  void onSetEmoji(BuildContext context, GlobalKey emojiKey) {
    final RenderBox button =
        emojiKey.currentContext!.findRenderObject() as RenderBox;
    Offset position = button.localToGlobal(Offset.zero);
    final double buttonHeight = button.size.height;
    final double buttonWidth = button.size.width;
    print(buttonHeight);
    print(position);

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: position.dy + buttonHeight + 19, right: buttonWidth + 4),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                width: 310,
                height: 62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ThemeColor.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset('assets/icons/emoji_happy.svg'),
                    SvgPicture.asset('assets/icons/emoji_congrat.svg'),
                    SvgPicture.asset('assets/icons/emoji_good.svg'),
                    SvgPicture.asset('assets/icons/emoji_sad.svg'),
                    SvgPicture.asset('assets/icons/emoji_angry.svg'),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/emoji.svg',
                  colorFilter:
                      ColorFilter.mode(ThemeColor.gray4, BlendMode.srcIn),
                ),
                const SizedBox(width: 3),
                Body3(value: '이모지', bold: true, color: ThemeColor.gray4),
                const SizedBox(width: 3),
                Body3(value: '0', color: ThemeColor.gray4)
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: ThemeColor.gray2),
                ),
              ),
              padding: const EdgeInsets.only(top: 12, bottom: 20),
              child: Row(
                children: [
                  GestureDetector(
                    key: emojiKey,
                    onTap: () {
                      onSetEmoji(context, emojiKey);
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/icons/emoji_empty.svg'),
                        const SizedBox(height: 4),
                        const Caption(value: '공감하기'),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
