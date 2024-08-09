import 'package:flutter/material.dart';
import 'package:puppycode/pages/onboarding/register.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('어서오시오'),
      ),
      body: Center(
          child: TextButton(
        child: const Text('register'),
        onPressed: () {
          Get.to(() => const RegistrationPage());
        },
      )),
      bottomSheet: Container(
        constraints: const BoxConstraints(maxHeight: 102),
        margin: const EdgeInsets.fromLTRB(45, 0, 45, 75),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SignupButton(text: '카카오로 시작하기', type: SignupType.kakao),
            SizedBox(height: 12),
            SignupButton(text: 'Continue with Apple', type: SignupType.apple)
          ],
        ),
      ),
    );
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
