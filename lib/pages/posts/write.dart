import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:puppycode/shared/photo_item.dart';
import 'package:puppycode/shared/typography.dart';

class PostWritePage extends StatelessWidget {
  const PostWritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                PhotoItem(),
                // 산책 input
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Body1(value: '산책한 시간'),
                    Container(
                        child: Row(
                      children: [
                        TextButton(onPressed: () => {}, child: Text('20분 내외'))
                      ],
                    ))
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: TextButton(
          onPressed: () => {},
          child: Text('오늘도 산책 완료!'),
        ));
  }
}

enum SignupType { kakao, apple }

class SignupButton extends StatelessWidget {
  const SignupButton({
    required this.text,
    required this.type,
    super.key,
  });

  final String text;
  final SignupType type;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextButton(
        onPressed: () => {},
        style: TextButton.styleFrom(
            backgroundColor:
                type == SignupType.kakao ? Colors.yellow : Colors.black,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.5,
            color: type == SignupType.kakao ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
