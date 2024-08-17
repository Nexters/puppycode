import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'package:puppycode/config.dart';
import 'package:puppycode/pages/onboarding/register.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/http.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const storage = FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthToken();
    });
  }

  void _checkAuthToken() async {
    if (Config.isLocal) Get.offAllNamed('/');
    String? value = await storage.read(key: 'authToken');
    if (value != null) {
      Get.offAllNamed('/');
    }
  }

  void _onLogin(String token) async {
    await storage.write(key: 'authToken', value: token);
    Get.offAllNamed('/');
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SignupButton(
              text: '카카오로 시작하기',
              type: SignupType.kakao,
              onLogin: _onLogin,
            ),
            const SizedBox(height: 12),
            SignupButton(
              text: 'Continue with Apple',
              type: SignupType.apple,
              onLogin: _onLogin,
            )
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
    required this.onLogin,
    super.key,
  });

  final String text;
  final SignupType type;
  final void Function(String) onLogin;

  void _login() async {
    if (type != SignupType.kakao) return;
    try {
      await UserApi.instance.loginWithKakaoTalk();
      var me = await UserApi.instance.me();
      try {
        var loginResult = await HttpService.getOne('/auth/login',
            params: {'oauthIdentifier': me.id.toString()});
        String token = loginResult['token'] ?? '';
        if (token.isEmpty) return;
        onLogin(token);
      } catch (err) {
        Get.toNamed('/signup', arguments: {
          'oAauthToken': me.id.toString(),
          'profileUrl': me.kakaoAccount?.profile?.profileImageUrl ?? '',
          'provider': 'KAKAO'
        });
      }
    } catch (err) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    if (type == SignupType.apple) {
      return TextButton(
        onPressed: () => {_login()},
        style: TextButton.styleFrom(
            backgroundColor: Colors.black,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14.5,
            color: Colors.white,
          ),
        ),
      );
    }

    return Expanded(
        child: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/kakao.png'))),
    ));
  }
}
