import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:puppycode/shared/photo_item.dart';
import 'package:puppycode/shared/styles/button.dart';
import 'package:puppycode/shared/typography.dart';

class PostWritePage extends StatelessWidget {
  const PostWritePage({super.key});

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
                        child: const SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              OptionButton(
                                label: '20분 내외',
                                isSelected: false,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              OptionButton(
                                label: '20분~40분',
                                isSelected: true,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              OptionButton(
                                label: '40분~1시간',
                                isSelected: false,
                              )
                            ],
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
  const OptionButton({
    super.key,
    required this.isSelected,
    required this.label,
  });

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
      onPressed: () => {},
      child: Body3(
        value: label,
        bold: isSelected,
        color: isSelected ? null : _textColor,
      ),
    );
  }
}
