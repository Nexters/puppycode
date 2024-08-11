import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puppycode/pages/feeds/success.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/photo_item.dart';
import 'package:puppycode/shared/styles/button.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class FeedWritePage extends StatefulWidget {
  const FeedWritePage({super.key});

  @override
  State<FeedWritePage> createState() => _FeedWritePageState();
}

const _kInitialTime = 20;
const _kInitialGap = 20;
const _kOptionCount = 3;

class _FeedWritePageState extends State<FeedWritePage> {
  String? selectedTime;
  List<String> options = [];

  @override
  void initState() {
    super.initState();
    var options = [];
    for (int i = 0; i < _kOptionCount; i++) {
      if (i == 0) {
        options.add('$_kInitialTime분 미만');
      } else {
        options.add('$_kInitialTime분~${_kInitialTime + _kInitialGap}');
      }
    }
  }

  List<Widget> _optionButtons() {
    List<Widget> widgets = [];
    for (int i = 0; i < 3; i++) {
      String value = '';
      if (i == 0) {
        value = '$_kInitialTime분 미만';
      } else {
        value =
            '${_kInitialTime + (i - 1) * _kInitialTime}분~${_kInitialTime + _kInitialGap}분';
      }

      widgets.add(OptionButton(
          label: value,
          isSelected: selectedTime == value,
          onPressed: () => {_onTimeButtonPressd(value)}));

      if (i != 2) {
        widgets.add(const SizedBox(
          width: 12,
        ));
      }
    }

    return widgets;
  }

  void _onTimeButtonPressd(String value) {
    setState(() {
      selectedTime = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SharedAppBar(
          leftOptions: AppBarLeft(iconType: LeftIconType.CLOSE),
          centerOptions: AppBarCenter(label: '산책 기록하기'),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const PhotoItem(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Body1(value: '산책한 시간'),
                    Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _optionButtons(),
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 12),
            child: DefaultElevatedButton(
              onPressed: () => {Get.to(() => const FeedCreateSuccessPage())},
              text: '오늘도 산책완료!',
            ),
          ),
        ));
  }
}

class OptionButton extends StatelessWidget {
  const OptionButton(
      {super.key,
      required this.isSelected,
      required this.label,
      required this.onPressed});

  final VoidCallback onPressed;
  final String label;
  final bool isSelected;
  static const _borderColor = Color(0xFFE4EAEE);
  static const _textColor = Color(0xFF72757A);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
          side:
              BorderSide(color: isSelected ? ThemeColor.primary : _borderColor),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)))),
      onPressed: onPressed,
      child: Body4(
        value: label,
        bold: isSelected,
        color: isSelected ? null : _textColor,
      ),
    );
  }
}
