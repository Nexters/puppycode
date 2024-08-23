import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:puppycode/apis/models/reaction.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/caption.dart';
import 'package:puppycode/shared/states/user.dart';

class ReactionEmojiList extends StatefulWidget {
  final List<Reaction> reactions;
  final String walkLogId;
  final Function refetch;
  final Function onSubmitted;

  const ReactionEmojiList({
    super.key,
    required this.reactions,
    required this.walkLogId,
    required this.refetch,
    required this.onSubmitted,
  });

  @override
  State<ReactionEmojiList> createState() => _ReactionEmojiListState();
}

class _ReactionEmojiListState extends State<ReactionEmojiList> {
  bool hasMyEmoji = false;
  final List<String> emojis = [
    'like',
    'congratulation',
    'impressive',
    'sad',
    'angry',
  ];

  @override
  void initState() {
    super.initState();
    checkEmojiPosted();
  }

  void checkEmojiPosted() {
    final userController = Get.find<UserController>();
    final user = userController.user.value;

    //내 유저 아이디가 reactions.writerId랑 같은지 확인
    hasMyEmoji = widget.reactions.any((item) => item.writerId == user!.id);
  }

  final GlobalKey emojiKey = GlobalKey();

  void onSetEmoji(BuildContext context, GlobalKey emojiKey) {
    final RenderBox button =
        emojiKey.currentContext!.findRenderObject() as RenderBox;
    Offset position = button.localToGlobal(Offset.zero);
    final double buttonHeight = button.size.height;
    final double buttonWidth = button.size.width;

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
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(2, 2),
                      blurRadius: 20,
                      color: ThemeColor.black.withOpacity(0.08),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: emojis.map((emoji) {
                    return EmojiButton(
                        emoji: emoji,
                        onPressed: () {
                          widget.onSubmitted(emoji);
                          setState(() {
                            hasMyEmoji = true;
                          });
                          Get.back();
                        });
                  }).toList(),
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
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [
            ThemeColor.white.withOpacity(0.2),
            Colors.transparent,
            ThemeColor.white.withOpacity(0.8),
          ],
          stops: const [-1, 0.9, 1],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: ThemeColor.gray2),
          ),
        ),
        padding: const EdgeInsets.only(top: 12, bottom: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              if (!hasMyEmoji)
                Row(
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
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              for (var reaction in widget.reactions)
                EmojiReactionListItem(
                    reactionType: reaction.reactionType,
                    writerName: reaction.writerName),
            ],
          ),
        ),
      ),
    );
  }
}

class EmojiButton extends StatelessWidget {
  final String emoji;
  final VoidCallback onPressed;

  const EmojiButton({
    super.key,
    required this.emoji,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: SvgPicture.asset('assets/icons/emoji_$emoji.svg'));
  }
}

class EmojiReactionListItem extends StatelessWidget {
  final String reactionType;
  final String writerName;

  const EmojiReactionListItem({
    super.key,
    required this.reactionType,
    required this.writerName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/icons/emoji_$reactionType.svg',
          width: 40,
          height: 40,
        ),
        const SizedBox(height: 4),
        Caption(
          value: writerName,
          color: ThemeColor.gray5,
          maxLength: 3,
        )
      ],
    );
  }
}
