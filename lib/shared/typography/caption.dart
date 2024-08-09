import 'package:flutter/material.dart';
import 'package:puppycode/shared/styles/color.dart';

Color _kDefaultTextColor = ThemeColor.gray6;

class Caption extends StatelessWidget {
  const Caption({
    super.key,
    required this.value,
    this.color,
  });

  final Color? color;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
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
      color: color ?? _kDefaultTextColor,
      height: 16 / 12,
    );
  }
}
