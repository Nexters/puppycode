import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

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