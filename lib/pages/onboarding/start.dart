import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '개떡이와 오늘도\n산책하러 갈까요?',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
          ),
          TextButton(
              onPressed: () => {Get.toNamed('/home')},
              child: const Text('피드로 ㄱㄱ'))
        ],
      )),
    );
  }
}
