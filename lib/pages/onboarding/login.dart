import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'package:puppycode/pages/onboarding/register.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // 로컬 확인하고
    // 있으면 메인 고고 리다이렉트
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  void _login() async {
    if (type != SignupType.kakao) return;
    try {
      await UserApi.instance.loginWithKakaoTalk();
      var me = await UserApi.instance.me();
      print(me.id);
      // get을 찌르고 ~
      // true 토큰 저장하고 메인으로
      // false register로 토큰 물고 이동하기
      // API를 쏘고 ~
      // 토큰받고
      // 로컬에 박고
      // 메인으로 리다이렉트
    } catch (err) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextButton(
        onPressed: () => {_login()},
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
