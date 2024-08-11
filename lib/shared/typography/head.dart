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

const _kDefaultTextColor = Color(0xFF1E2022);

class HeadTextStyle {
  static getH1Style({Color? color}) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      letterSpacing: 24 * -0.012,
      color: color ?? _kDefaultTextColor,
      height: 33 / 24,
    );
  }

  static getH2Style({Color? color}) {
    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      letterSpacing: 22 * -0.012,
      color: color ?? _kDefaultTextColor,
      height: 31 / 22,
    );
  }

  static getH3Style({Color? color}) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: 20 * -0.012,
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
