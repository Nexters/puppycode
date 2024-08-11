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

class Body3 extends StatelessWidget {
  const Body3({
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
      style: BodyTextStyle.getBody3Style(color: color, bold: bold),
    );
  }
}

class Body4 extends StatelessWidget {
  const Body4(
      {super.key,
      required this.value,
      this.color,
      this.fontWeight,
      this.textShadow});

  final String value;
  final Color? color;
  final Shadow? textShadow;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: BodyTextStyle.getBody4Style(
          color: color, fontWeight: fontWeight, textShadow: textShadow),
    );
  }
}

class BodyTextStyle {
  static getBody1Style({Color? color, bool? bold}) {
    return TextStyle(
      fontSize: 17,
      fontWeight: bold == true ? FontWeight.w600 : FontWeight.w400,
      letterSpacing: -0.01 * 17,
      color: color ?? _kDefaultTextColor,
      height: 24 / 17,
      decoration: TextDecoration.none,
    );
  }

  static getBody2Style({Color? color, bool? bold}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: bold == true ? FontWeight.w600 : FontWeight.w400,
      letterSpacing: -0.01 * 16,
      color: color ?? _kDefaultTextColor,
      height: 24 / 16,
    );
  }

  static getBody3Style({Color? color, bool? bold}) {
    return TextStyle(
      fontSize: 15,
      fontWeight: bold == true ? FontWeight.w600 : FontWeight.w400,
      letterSpacing: -0.01 * 15,
      color: color ?? _kDefaultTextColor,
      height: 23 / 15,
    );
  }

// medium 추가
  static getBody4Style(
      {Color? color, FontWeight? fontWeight, Shadow? textShadow}) {
    return TextStyle(
      fontSize: 14,
      fontWeight:
          fontWeight, // semibold, medium, regular 세가지 (FontWeight.w600, w500, w400)
      letterSpacing: -0.01 * 14,
      color: color ?? _kDefaultTextColor,
      height: 18 / 14,
      shadows: textShadow != null ? <Shadow>[textShadow] : null,
    );
  }
}
