import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/pages/feedDetails/comment_item.dart';
import 'package:puppycode/pages/feedDetails/emoji_item.dart';
import 'package:puppycode/pages/feedDetails/reaction_tab_view.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class ReactionContents extends StatefulWidget {
  const ReactionContents({super.key});

  @override
  State<ReactionContents> createState() => _ReactionContentsState();
}

class _ReactionContentsState extends State<ReactionContents> {
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
              Body3(value: '0', color: ThemeColor.gray4)
            ],
          ),
          const ReactionEmojiListItem(),
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
              Body3(value: '4', color: ThemeColor.gray4)
            ],
          ),
          const SizedBox(height: 4),
          Expanded(
            child: RawScrollbar(
              thumbColor:
                  ThemeColor.scroll, // 등록된 색상이 없어서 .. ScrollBar 색상으로 등록해뒀어용
              radius: const Radius.circular(100),
              thickness: 4,
              child: const SingleChildScrollView(
                child: Column(
                  children: [
                    ReactionCommentListItem(
                        userName: '푸름이', comment: 'ㅋㅋㅋ우리집 강아지도 산책만 들으면 환장을 함'),
                    ReactionCommentListItem(
                        userName: '푸름이', comment: 'ㅋㅋㅋ우리집 강아지도 산책만 들으면 환장을 함'),
                    ReactionCommentListItem(
                        userName: '푸름이',
                        comment: '우리집 강아지가 젤 귀여움 ☀︎',
                        isFeedWriter: true),
                    ReactionCommentListItem(
                        userName: '푸름이', comment: 'ㅋㅋㅋ우리집 강아지도 산책만 들으면 환장을 함'),
                    ReactionCommentListItem(
                        userName: '푸름이', comment: 'ㅋㅋㅋ우리집 강아지도 산책만 들으면 환장을 함'),
                    ReactionCommentListItem(
                        userName: '푸름이', comment: 'ㅋㅋㅋ우리집 강아지도 산책만 들으면 환장을 함'),
                    ReactionCommentListItem(
                        userName: '푸름이', comment: 'ㅋㅋㅋ우리집 강아지도 산책만 들으면 환장을 함'),
                  ],
                ),
              ),
            ),
          ),
          CommentTextField(textFieldController: _commentController),
        ],
      ),
    );
  }
}
