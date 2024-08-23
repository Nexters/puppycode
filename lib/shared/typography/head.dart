import 'package:flutter/material.dart';
import 'package:puppycode/shared/styles/color.dart';

class Head1 extends StatelessWidget {
  const Head1({super.key, required this.value, this.color, this.align});

  final String value;
  final Color? color;
  final TextAlign? align;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      textAlign: align ?? TextAlign.start,
      style: HeadTextStyle.getH1Style(color: color),
    );
  }
}

class Head2 extends StatelessWidget {
  const Head2({super.key, required this.value, this.color});

  final Color? color;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: HeadTextStyle.getH2Style(color: color),
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

class Head4 extends StatelessWidget {
  const Head4({super.key, required this.value, this.color});

  final Color? color;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: HeadTextStyle.getH4Style(color: color),
    );
  }
}

Color _kDefaultTextColor = ThemeColor.gray6;

class HeadTextStyle {
  static getH1Style({Color? color}) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700, // bold
      letterSpacing: -0.012 * 24,
      color: color ?? _kDefaultTextColor,
      height: 33 / 24,
    );
  }

  static getH2Style({Color? color}) {
    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700, // bold
      letterSpacing: -0.012 * 22,
      color: color ?? _kDefaultTextColor,
      height: 31 / 22,
    );
  }

  static getH3Style({Color? color}) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600, // semibold
      letterSpacing: -0.012 * 20,
      color: color ?? _kDefaultTextColor,
      height: 28 / 20,
    );
  }

  static getH4Style({Color? color}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600, // semibold
      letterSpacing: -0.012 * 18,
      color: color ?? _kDefaultTextColor,
      height: 24 / 18,
    );
  }
}
