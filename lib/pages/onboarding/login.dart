import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'package:puppycode/config.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/http.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/states/user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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
    try {
      String? value = await storage.read(key: 'authToken');
      if (value != null) {
        Get.offAllNamed('/');
      }
    } catch (e) {}
  }

  void _onLogin(String token) async {
    final userController = Get.find<UserController>();
    await storage.write(key: 'authToken', value: token);
    await userController.refreshData();
    Get.offAllNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          width: MediaQuery.of(context).size.width,
          child: Stack(fit: StackFit.loose, children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/logo.svg', width: 200),
                  const SizedBox(height: 10),
                  const Body2(value: '친구와 공유하는 반려견 산책 일지', bold: true),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 80, horizontal: 60),
                    child: Image.asset('assets/images/pawpaw_main.png'),
                  ),
                ],
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
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
                ))
          ]),
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

  void _checkUserRegistration(String oauthIdentifier, String provider,
      {Map<String, String>? additionalInfo}) async {
    try {
      var loginResult = await HttpService.getOne('auth/login', params: {
        'oauthIdentifier': oauthIdentifier,
        'deviceToken': Config.FIREBASE_TOKEN
      });
      String token = loginResult['token'] ?? '';
      if (token.isNotEmpty) onLogin(token);
    } catch (err) {
      Get.toNamed('/signup', arguments: {
        'oAauthToken': oauthIdentifier,
        'provider': provider,
        ...?additionalInfo,
      });
    }
  }

  void _appleLogin() async {
    try {
      AuthorizationCredentialAppleID user =
          await SignInWithApple.getAppleIDCredential(scopes: []);
      if (user.userIdentifier == null) return;
      _checkUserRegistration(user.userIdentifier!, 'APPLE');
    } catch (err) {
      return;
    }
  }

  void _kakaoLogin() async {
    try {
      if (await isKakaoTalkInstalled()) {
        await UserApi.instance.loginWithKakaoTalk();
      } else {
        await UserApi.instance.loginWithKakaoAccount();
      }
      var me = await UserApi.instance.me();
      _checkUserRegistration(me.id.toString(), 'KAKAO', additionalInfo: {
        'profileUrl': me.kakaoAccount?.profile?.profileImageUrl ?? '',
      });
    } catch (err) {
      //
    }
  }

  void _login() async {
    if (type == SignupType.apple) {
      _appleLogin();
    } else {
      _kakaoLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.9;

    return GestureDetector(
      onTap: () => {_login()},
      child: SizedBox(
        width: width,
        height: width * 0.16,
        child: SvgPicture.asset(
            type == SignupType.kakao
                ? 'assets/icons/kakao_login.svg'
                : 'assets/icons/apple_login.svg',
            width: width),
      ),
    );
  }
}
