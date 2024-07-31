import 'package:flutter/material.dart';
import 'package:puppycode/shared/styles/button.dart';
import 'package:get/get.dart';

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
      isValidName = name.length > 5;
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
      child: const Column(
        children: [
          Text(
            '우리집 강아지 이름을\n설정해볼까요?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Text('키우는 강아지가 없어도 괜찮아요',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontSize: 16))
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
          onPressed: () => {},
          disabled: !widget.isActive,
        ));
  }
}
