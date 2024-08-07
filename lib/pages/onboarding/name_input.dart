import 'package:flutter/material.dart';
import 'package:puppycode/pages/onboarding/start.dart';
import 'package:puppycode/shared/styles/button.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String name = '';
  bool isValidName = false;

  validateName() {
    setState(() {
      isValidName = name.length > 2;
    });
  }

  _getInputBorderStyle(bool focus) {
    return OutlineInputBorder(
      borderSide:
          BorderSide(color: focus ? ThemeColor.primary : ThemeColor.gray2),
      borderRadius: BorderRadius.circular(20),
    );
  }

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
            TextField(
              onChanged: (value) {
                setState(() {
                  name = value;
                  validateName();
                });
              },
              decoration: InputDecoration(
                hintText: '강아지 이름',
                focusedBorder: _getInputBorderStyle(true),
                enabledBorder: _getInputBorderStyle(false),
                contentPadding: const EdgeInsets.all(16),
                labelStyle: BodyTextStyle.getBody1Style(bold: true),
                hintStyle: BodyTextStyle.getBody1Style(color: ThemeColor.gray4),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: DefaultTextButton(
                text: '안할래요',
                onPressed: () => Get.back(),
              ),
            ),
            const SizedBox(width: 17),
            NameConfirmButton(isActive: isValidName),
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

class NameConfirmButton extends StatefulWidget {
  final bool isActive;

  const NameConfirmButton({
    required this.isActive,
    super.key,
  });

  @override
  State<NameConfirmButton> createState() => _NameConfirmButtonState();
}

class _NameConfirmButtonState extends State<NameConfirmButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: DefaultTextButton(
          text: '등록하기',
          onPressed: () => {Get.to(() => const StartPage())},
          disabled: !widget.isActive,
        ));
  }
}
