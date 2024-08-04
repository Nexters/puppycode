import 'package:flutter/material.dart';

class Head3 extends StatelessWidget {
  const Head3({super.key, required this.value, this.color});

  final Color? color;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: HeadTextStyle.getH3Style(color: color),
    );
  }
}

const _kDefaultTextColor = Color(0xFF1E2022);

class HeadTextStyle {
  static getH3Style({Color? color}) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.2,
      color: color ?? _kDefaultTextColor,
      height: 28 / 20,
    );
  }
}
