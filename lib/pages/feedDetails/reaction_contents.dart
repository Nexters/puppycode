import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/apis/models/comment.dart';
import 'package:puppycode/apis/models/reaction.dart';
import 'package:puppycode/pages/feedDetails/comment_item.dart';
import 'package:puppycode/pages/feedDetails/comment_textfield.dart';
import 'package:puppycode/pages/feedDetails/emoji_item.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class ReactionContents extends StatelessWidget {
  final List<Comment> comments;
  final List<Reaction> reactions;
  final Function refetch;
  final String walkLogId;

  ReactionContents({
    super.key,
    required this.refetch,
    required this.comments,
    required this.reactions,
    required this.walkLogId,
  });

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 0 : 46,
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/emoji.svg',
                colorFilter:
                    ColorFilter.mode(ThemeColor.gray4, BlendMode.srcIn),
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 3),
              Body3(value: '이모지', bold: true, color: ThemeColor.gray4),
              const SizedBox(width: 3),
              Body3(value: reactions.length.toString(), color: ThemeColor.gray4)
            ],
          ),
          ReactionEmojiList(
            reactions: reactions,
            walkLogId: walkLogId,
            refetch: refetch,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/talk.svg',
                colorFilter:
                    ColorFilter.mode(ThemeColor.gray4, BlendMode.srcIn),
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 3),
              Body3(value: '댓글', bold: true, color: ThemeColor.gray4),
              const SizedBox(width: 3),
              Body3(value: comments.length.toString(), color: ThemeColor.gray4)
            ],
          ),
          if (comments.isEmpty)
            Column(
              children: [
                const SizedBox(height: 20), // 가운데 못해..~
                Image.asset(
                  'assets/images/comment_nothing.png',
                  width: 120,
                ),
                Body3(value: '첫 댓글을 달아보세요!', color: ThemeColor.gray4),
              ],
            ),
          const SizedBox(height: 4),
          Expanded(
            child: RawScrollbar(
              thumbColor: ThemeColor.scroll,
              radius: const Radius.circular(100),
              thickness: 4,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var comment in comments)
                      ReactionCommentListItem(
                        refetch: refetch,
                        commentId: comment.id,
                        userName: comment.writerName,
                        comment: comment.content,
                        profileUrl: comment.writerProfileUrl,
                        isFeedWriter: comment.isWriter,
                      ),
                  ],
                ),
              ),
            ),
          ),
          CommentTextField(
            textFieldController: _commentController,
            walkLogId: walkLogId,
          ),
        ],
      ),
    );
  }
}
