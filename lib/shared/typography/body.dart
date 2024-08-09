import 'package:flutter/material.dart';
import 'package:puppycode/shared/styles/color.dart';

Color _kDefaultTextColor = ThemeColor.gray6;

class Body1 extends StatelessWidget {
  const Body1({
    super.key,
    required this.value,
    this.color,
    this.bold = false,
  });


  final Color? color;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: BodyTextStyle.getBody1Style(color: color, bold: bold),
    );
  }
}

class Body2 extends StatelessWidget {
  const Body2({
    super.key,
    required this.value,
    this.color,
    this.bold = false,
  });

  final Color? color;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: BodyTextStyle.getBody2Style(color: color, bold: bold),
    );
  }
}

class Body4 extends StatelessWidget {
  const Body4(
      {super.key,
      required this.value,
      this.color,
      this.bold = false,
      this.textShadow});

  final String value;
  final Color? color;
  final Shadow? textShadow;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: BodyTextStyle.getBody4Style(
          color: color, bold: bold, textShadow: textShadow),
    );
  }
}

class BodyTextStyle {
  static getBody1Style({Color? color, bool? bold}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: bold == true ? FontWeight.w600 : FontWeight.w400,
      letterSpacing: -1,
      color: color ?? _kDefaultTextColor,
      height: 22 / 16,
    );
  }

  static getBody2Style({Color? color, bool? bold}) {
    return TextStyle(
      fontSize: 15,
      fontWeight: bold == true ? FontWeight.w600 : FontWeight.w400,
      letterSpacing: -1,
      color: color ?? _kDefaultTextColor,
      height: 22 / 15,
    );
  }

  static getBody4Style({Color? color, bool? bold, Shadow? textShadow}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: bold == true ? FontWeight.w600 : FontWeight.w400,
      letterSpacing: -1,
      color: color ?? _kDefaultTextColor,
      height: 18 / 14,
      shadows: textShadow != null ? <Shadow>[textShadow] : null,
    );
  }
}
