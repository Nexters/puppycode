import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:puppycode/shared/photo_item.dart';
import 'package:puppycode/shared/styles/button.dart';
import 'package:puppycode/shared/typography.dart';

class PostWritePage extends StatefulWidget {
  const PostWritePage({super.key});

  @override
  State<PostWritePage> createState() => _PostWritePageState();
}

const _kInitialTime = 20;
const _kInitialGap = 20;

class _PostWritePageState extends State<PostWritePage> {
  String? selectedTime;
  List<String> options = [];

  @override
  void initState() {
    super.initState();
    var options = [];
    for (int i = 0; i < 3; i++) {
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
        appBar: AppBar(),
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DefaultTextButton(
              onPressed: () => {},
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
  static const _selectBorderColor = Color(0xFF36DBBF);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
          side:
              BorderSide(color: isSelected ? _selectBorderColor : _borderColor),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)))),
      onPressed: onPressed,
      child: Body3(
        value: label,
        bold: isSelected,
        color: isSelected ? null : _textColor,
      ),
    );
  }
}
