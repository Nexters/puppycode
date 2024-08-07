import 'package:flutter/material.dart';
import 'package:puppycode/pages/onboarding/start.dart';
import 'package:puppycode/shared/styles/button.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';

class NameInputPage extends StatefulWidget {
  const NameInputPage({ super.key });

  @override
  State<NameInputPage> createState() => _NameInputPageState();
}

class _NameInputPageState extends State<NameInputPage> {
  String name = '';
  bool isValidName = false;

  validateName() {
    setState(() {
      isValidName = name.length > 2;
    });
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
            const NameGuide(),
            TextField(
              onChanged: (value) {
                setState(() {
                  name = value;
                  validateName();
                });
              },
              decoration: const InputDecoration(
                hintText: '개떡이',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
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

class NameGuide extends StatelessWidget {
  const NameGuide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Head2(value: '우리 집 강아지의 이름과\n사는 곳을 설정해 볼까요?'),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Body2(
                value: '키우는 강아지가 없어도 괜찮아요',
                color: Colors.black.withOpacity(0.6)),
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
