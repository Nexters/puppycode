import 'package:flutter/material.dart';

class Head1 extends StatelessWidget {
  const Head1({super.key, required this.value, this.color});

  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: HeadTextStyle.getH1Style(color: color),
    );
  }
}

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
  static getH1Style({Color? color}) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.2,
      color: color ?? _kDefaultTextColor,
      height: 32 / 24,
    );
  }

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
