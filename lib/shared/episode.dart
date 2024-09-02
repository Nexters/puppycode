import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class Episode extends StatefulWidget {
  const Episode({
    super.key,
    this.isInput = false,
    this.controller,
    this.content = '',
    this.isWriter = true,
    this.id,
    this.focusNode,
  });

  static const String _inputHintText = '산책에서 생긴 에피소드를 기록해 보아요.';

  final bool isInput;
  final TextEditingController? controller;
  final String content;
  final bool isWriter;
  final String? id;
  final FocusNode? focusNode;

  @override
  State<Episode> createState() => _EpisodeState();
}

class _EpisodeState extends State<Episode> {
  late FocusNode _focusNode;
  Color _iconColor = ThemeColor.gray4;
  Color _borderColor = ThemeColor.gray2;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      setState(() {
        if (_focusNode.hasFocus) {
          _iconColor = ThemeColor.primary;
          _borderColor = ThemeColor.primary;
        } else {
          _iconColor = ThemeColor.gray4;
          _borderColor = ThemeColor.gray2;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _borderColor, width: 1.2)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/episode.svg',
                        width: 24,
                        colorFilter:
                            ColorFilter.mode(_iconColor, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 4),
                      Body2(
                          value: widget.content.isEmpty && !widget.isInput
                              ? '오늘의 에피소드 추가하기'
                              : '오늘의 에피소드',
                          bold: true)
                    ],
                  ),
                  const SizedBox(height: 8),
                  widget.isInput
                      ? TextField(
                          focusNode: widget.focusNode,
                          cursorHeight: 23,
                          maxLines: null,
                          controller: widget.controller,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: Episode._inputHintText,
                            labelStyle: BodyTextStyle.getBody3Style(),
                            hintStyle: BodyTextStyle.getBody3Style(
                                color: ThemeColor.gray4),
                          ),
                        )
                      : Body3(
                          value: widget.content.isEmpty
                              ? '산책에서 생긴 에피소드를 기록해 보아요.'
                              : widget.content,
                          color: widget.content.isNotEmpty
                              ? ThemeColor.gray5
                              : ThemeColor.gray4,
                        )
                ],
              ),
            ),
            if (widget.content.isEmpty && !widget.isInput)
              GestureDetector(
                onTap: () {
                  Get.toNamed(
                    '/create',
                    arguments: {
                      'id': widget.id,
                      'from': 'episode',
                    },
                  );
                },
                child: SvgPicture.asset(
                  "assets/icons/chevron_right.svg",
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    ThemeColor.gray3,
                    BlendMode.srcIn,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
