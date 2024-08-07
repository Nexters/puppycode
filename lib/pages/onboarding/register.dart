import 'package:flutter/material.dart';
import 'package:puppycode/pages/onboarding/start.dart';
import 'package:puppycode/shared/input.dart';
import 'package:puppycode/shared/styles/button.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GuideText(),
            TextInput(
              controller: _nameController,
              hintText: '강아지 이름',
              maxLength: 10,
            ),
            const SizedBox(height: 12),
            // 지역 INPUT
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
                child: DefaultTextButton(
              text: '등록하기',
              onPressed: () => {Get.to(() => const StartPage())},
            )),
          ],
        ),
      ),
    );
  }
}

class GuideText extends StatelessWidget {
  const GuideText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 64),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Head2(value: '우리 집 강아지의 이름과\n사는 곳을 설정해 볼까요?'),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Body2(value: '키우는 강아지가 없어도 괜찮아요.', color: Color(0xFF50555C)),
          )
        ],
      ),
    );
  }
}
