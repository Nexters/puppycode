import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool? showClearIcon;
  final int? maxLength;

  const TextInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.showClearIcon = true,
    this.maxLength,
  });

  static _getInputBorderStyle(bool focus) {
    return OutlineInputBorder(
      borderSide:
          BorderSide(color: focus ? ThemeColor.primary : ThemeColor.gray2),
      borderRadius: BorderRadius.circular(20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxLength,
      controller: controller,
      decoration: InputDecoration(
          counterText: '',
          hintText: hintText,
          focusedBorder: _getInputBorderStyle(true),
          enabledBorder: _getInputBorderStyle(false),
          contentPadding: const EdgeInsets.all(16),
          labelStyle: BodyTextStyle.getBody1Style(bold: true),
          hintStyle: BodyTextStyle.getBody1Style(color: ThemeColor.gray4),
          suffixIcon: controller.text.isNotEmpty && showClearIcon == true
              ? GestureDetector(
                  onTap: () => {controller.clear()},
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      'assets/icons/clear.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                )
              : null),
    );
  }
}
