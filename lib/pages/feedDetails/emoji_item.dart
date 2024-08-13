import 'package:flutter/material.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class ReactionEmojiListItem extends StatelessWidget {
  final String emoji;
  final String userName;

  const ReactionEmojiListItem({
    super.key,
    required this.emoji,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                    color: ThemeColor.gray2,
                    borderRadius: BorderRadius.circular(21.25)),
              ),
              Text(
                emoji,
                style: const TextStyle(
                    fontSize: 21.25,
                    letterSpacing: -0.012 * 21.25,
                    height: 29.8 / 21.25),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Body1(value: userName),
        ],
      ),
    );
  }
}
