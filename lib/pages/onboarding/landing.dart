import 'package:flutter/material.dart';
import 'package:puppycode/pages/onboarding/name_input.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Landing Page'),
      ),
      body: Center(
          child: TextButton(
        child: const Text('register'),
        onPressed: () {
          Get.to(() => const NameInputPage());
        },
      )),
      bottomSheet: Container(
        constraints: const BoxConstraints(maxHeight: 102),
        margin: const EdgeInsets.fromLTRB(45, 0, 45, 75),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SignupButton(text: '카카오로 시작하기'),
            SizedBox(height: 12),
            SignupButton(text: 'Continue with Apple')
          ],
        ),
      ),
    );
  }
}

class SignupButton extends StatelessWidget {
  const SignupButton({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      //height: 45,
      child: TextButton(
        onPressed: () => {},
        style: TextButton.styleFrom(
            backgroundColor: Colors.yellow,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14.5, color: Colors.black),
        ),
      ),
    );
  }
}
