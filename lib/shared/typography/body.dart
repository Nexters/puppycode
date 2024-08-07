import 'package:flutter/material.dart';

const _kDefaultTextColor = Color(0xFF1E2022);

class Body1 extends StatelessWidget {
  const Body1({super.key, required this.value, this.color});

  final Color? color;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: -1,
        color: color ?? _kDefaultTextColor,
        height: 22 / 16,
      ),
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
      style: TextStyle(
        fontSize: 15,
        fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
        letterSpacing: -1,
        color: color ?? _kDefaultTextColor,
        height: 22 / 15,
      ),
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
      style: TextStyle(
        fontSize: 14,
        fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
        letterSpacing: -1,
        color: color ?? _kDefaultTextColor,
        height: 18 / 14,
        shadows: textShadow != null ? <Shadow>[textShadow!] : null,
      ),
    );
  }
}
