import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/pages/feedDetails/comment_item.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class ReactionTabView extends StatefulWidget {
  const ReactionTabView({
    super.key,
  });

  @override
  State<ReactionTabView> createState() => _ReactionTabViewState();
}

class _ReactionTabViewState extends State<ReactionTabView> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 0 : 46,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ReactionCommentListItem(
                        userName: '푸름이', comment: 'ㅋㅋㅋ우리집 강아지도 산책만 들으면 환장을 함'),
                    ReactionCommentListItem(
                        userName: '샛별이', comment: '우리집 강아지가 젤 귀여움 ☀︎'),
                    ReactionCommentListItem(
                        userName: '샛별이', comment: '우리집 강아지가 젤 귀여움 ☀︎'),
                    ReactionCommentListItem(
                        userName: '푸름이',
                        comment: '우리집 강아지가 젤 귀여움 ☀︎',
                        isFeedWriter: true),
                    ReactionCommentListItem(
                        userName: '앙꼬',
                        comment: '미쳤다 저정도 정전기라면 모든 것을 이겨낼 수 있지 않을까 캬캬캬캬캬캬캬캬캬캬')
                  ],
                ),
              ),
            ),
          ),
          CommentTextField(textFieldController: _commentController)
        ],
      ),
    );
  }
}

class CommentTextField extends StatefulWidget {
  const CommentTextField({
    super.key,
    required TextEditingController textFieldController,
  }) : _commentController = textFieldController;

  final TextEditingController _commentController;

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget._commentController,
      focusNode: _focusNode,
      minLines: 1,
      maxLines: 3,
      cursorWidth: 2,
      cursorHeight: 16,
      cursorColor: ThemeColor.primary,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 8),
        hintText: '댓글 남기기...',
        hintStyle: BodyTextStyle.getBody3Style(color: ThemeColor.gray4),
        labelStyle: BodyTextStyle.getBody3Style(color: ThemeColor.gray6),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeColor.gray2),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeColor.gray2),
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIconConstraints: const BoxConstraints(
          minHeight: 28,
          minWidth: 28,
        ),
        suffixIcon: GestureDetector(
          onTap: () => {
            if (_isFocused)
              {widget._commentController.clear(), _focusNode.unfocus()}
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SvgPicture.asset('assets/icons/upload.svg'),
          ),
        ),
      ),
    );
  }
}
