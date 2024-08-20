import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/typography/head.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    String name = '';
    if (Get.arguments != null) {
      name = Get.arguments['name'] ?? '';
    }
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Head1(value: name.isNotEmpty ? '$name와 오늘도\n산책하러 갈까요?' : '산책하러 갈까요?'),
          GestureDetector(
            child: Padding(
                padding: const EdgeInsets.all(90),
                child: Image.asset('assets/images/pawpaw_hello.png')),
          )
        ],
      )),
    );
  }
}
