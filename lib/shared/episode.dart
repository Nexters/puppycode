import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    this.isInput = false,
    this.controller,
  });

  static const String _inputHintText = '오늘 산책하면서 생긴 에피소드를 공유해 보세요.';

  final bool isInput;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ThemeColor.gray2, width: 1.2)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/episode.svg',
                  colorFilter:
                      ColorFilter.mode(ThemeColor.gray4, BlendMode.srcIn),
                ),
                const SizedBox(width: 4),
                const Body2(value: '오늘의 에피소드', bold: true)
              ],
            ),
            const SizedBox(height: 8),
            isInput
                ? TextField(
                    cursorHeight: 23,
                    maxLines: null,
                    controller: controller,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      hintText: Episode._inputHintText,
                      labelStyle: BodyTextStyle.getBody3Style(),
                      hintStyle:
                          BodyTextStyle.getBody3Style(color: ThemeColor.gray4),
                    ),
                  )
                : Body3(
                    value:
                        '날이 너무 더워서 에어컨 틀어놓고 잠깐 나간 사이에 잠든 포포🐕 귀여워... 산책갈까? 하니까 바로 벌떡!!!ㅋㅋ',
                    color: ThemeColor.gray5,
                  )
          ],
        ),
      ),
    );
  }
}
