import 'package:flutter/material.dart';
import 'package:puppycode/shared/styles/color.dart';

class Caption extends StatelessWidget {
  static Color defaultColor = ThemeColor.gray4;

  const Caption({
    super.key,
    required this.value,
    this.color,
    this.maxLength,
  });

  final Color? color;
  final String value;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    var text = maxLength != null && value.length > maxLength!
        ? '${value.substring(0, maxLength)}...'
        : value;
    return Text(
      text,
      style: CaptionTextStyle.getCaptionStyle(color: color),
    );
  }
}

class CaptionTextStyle {
  static getCaptionStyle({Color? color}) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: color ?? Caption.defaultColor,
      height: 16 / 12,
    );
  }
}
