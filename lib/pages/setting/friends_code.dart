import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/typography.dart';

class FriendsCodePage extends StatefulWidget {
  const FriendsCodePage({super.key});

  @override
  State<FriendsCodePage> createState() => _FriendsCodePageState();
}

class _FriendsCodePageState extends State<FriendsCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Body1(
          value: '친구 코드 입력하기',
          bold: true,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.close_rounded,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const H2(value: '친구의 코드를 입력하면\n피드 친구를 맺을 수 있어요.'),
            const SizedBox(height: 8),
            const Body2(value: '맨 첫 칸을 꾹 눌러 코드 붙여넣기가 가능해요.'),
            const SizedBox(height: 120),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (index) => const CodeTextField(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CodeTextField extends StatelessWidget {
  const CodeTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 56,
      child: TextField(
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.2,
          color: Color(0xFF1E2022),
          height: 33 / 24,
        ),
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
        textAlign: TextAlign.center,
        cursorColor: Colors.black,
        cursorWidth: 1,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 217, 217, 217),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Color(0xFF36DBBF),
              width: 1,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 11.2),
        ),
      ),
    );
  }
}
