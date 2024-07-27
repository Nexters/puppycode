import 'package:flutter/material.dart';
import 'package:puppycode/shared/styles/button.dart';
//import 'package:get/get.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical:  30),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [NameGuide(), TextField(
              decoration: InputDecoration(
                  hintText: '개떡이',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                ),
                ),),],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        margin: const EdgeInsets.fromLTRB(0,0,0,50),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: DefaultTextButton(
                text: '안할래요',
                onPressed: () => {},
              ),
            ),
            Expanded(
              flex: 2,
              child: DefaultTextButton(
                text: '등록하기',
                onPressed: () => {},)),
          ],
        ),
      ),
    );
  }
}

class NameGuide extends StatelessWidget {
  const NameGuide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 64),
      child: const Column(
        children: [
          Text(
          '우리집 강아지 이름을\n설정해볼까요?',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Text('키우는 강아지가 없어도 괜찮아요', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 16))],
      ),
    );
  }
}
