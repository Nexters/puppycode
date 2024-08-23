import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/typography/head.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed('/');
    });
  }

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
          Head1(
            value: name.isNotEmpty ? '$name와 오늘도\n산책하러 갈까요?' : '산책하러 갈까요?',
            align: TextAlign.center,
          ),
          GestureDetector(
            onTap: () => {Get.offAllNamed('/')},
            child: Padding(
                padding: const EdgeInsets.all(90),
                child: Image.asset('assets/images/pawpaw_hello.png')),
          )
        ],
      )),
    );
  }
}
