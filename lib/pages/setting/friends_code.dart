import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/http.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';

class FriendsCodePage extends StatefulWidget {
  const FriendsCodePage({super.key});

  @override
  State<FriendsCodePage> createState() => _FriendsCodePageState();
}

class _FriendsCodePageState extends State<FriendsCodePage> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  String errorMessage = '';

  void _handleInputChange(int index, String value) {
    if (value.length == 1) {
      if (index < 5) {
        FocusScope.of(context).nextFocus(); // 다음 필드로 포커스 이동
      }
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).previousFocus(); // 이전 필드로 포커스 이동
    }
  }

  void _handlePaste(String value) {
    for (int i = 0; i < value.length && i < 6; i++) {
      _controllers[i].text = value[i];
      _handleInputChange(i, value[i]);
    }
  }

  Future<void> _createFriend(String code) async {
    try {
      await HttpService.post('friends', body: {"code": code}).then((_) {
        setState(() {
          errorMessage = '';
        });
      });
    } catch (error) {
      print('createFriend error: $error');
      setState(() {
        errorMessage = '잘못된 코드입니다!';
      });
    }
  }

  void _onSubmit() {
    String code = _controllers.map((controller) => controller.text).join('');

    if (code.length == 6) {
      _createFriend(code);
    } else {
      setState(() {
        errorMessage = '잘못된 코드입니다~';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppBar(
        leftOptions: AppBarLeft(iconType: LeftIconType.CLOSE),
        centerOptions: AppBarCenter(label: '친구 코드 입력하기'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Head2(value: '친구의 코드를 입력하면\n피드 친구를 맺을 수 있어요.'),
            const SizedBox(height: 8),
            const Body2(value: '맨 첫 칸을 꾹 눌러 코드 붙여넣기가 가능해요.'),
            const SizedBox(height: 120),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (index) => CodeTextField(
                    controller: _controllers[index],
                    onChanged: (value) {
                      _handleInputChange(index, value);
                    },
                    onPaste: (value) {
                      _handlePaste(value);
                    },
                    onSubmitted: (value) {
                      _onSubmit();
                    }),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Body4(
                  value: errorMessage,
                  color: ThemeColor.error,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}

class CodeTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onPaste;
  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;

  const CodeTextField({
    required this.onChanged,
    required this.onPaste,
    required this.controller,
    required this.onSubmitted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 56,
      child: TextField(
        controller: controller,
        style: HeadTextStyle.getH1Style(color: ThemeColor.gray5),
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
        textAlign: TextAlign.center,
        cursorColor: ThemeColor.primary,
        cursorHeight: 18,
        onChanged: (value) {
          onChanged(value);
        },
        onSubmitted: (value) {
          onSubmitted(value);
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: ThemeColor.gray2,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 11.2),
        ),
        onTap: () async {
          final data = await Clipboard.getData(Clipboard.kTextPlain);
          if (data?.text != null) {
            onPaste(data!.text!); // 붙여넣기된 문자열 처리
          }
        },
      ),
    );
  }
}
