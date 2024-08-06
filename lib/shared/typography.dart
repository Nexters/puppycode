import 'package:flutter/material.dart';

const _kDefaultTextColor = Color(0xFF1E2022);

class H1 extends StatelessWidget {
  const H1({super.key, required this.value, this.color});

  final Color? color;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.2,
        color: color ?? _kDefaultTextColor,
        height: 33 / 24,
      ),
    );
  }
}

class H2 extends StatelessWidget {
  const H2({super.key, required this.value, this.color});

  final Color? color;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: -1,
        color: color ?? _kDefaultTextColor,
        height: 31 / 22,
      ),
    );
  }
}

class Body1 extends StatelessWidget {
  const Body1({super.key, required this.value, this.color, this.bold = false});

  final Color? color;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 17,
        fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
        letterSpacing: -1,
        color: color ?? _kDefaultTextColor,
        height: 24 / 17,
      ),
    );
  }
}

class Body2 extends StatelessWidget {
  const Body2({super.key, required this.value, this.color, this.bold = false});

  final Color? color;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 16,
        fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
        letterSpacing: -1,
        color: color ?? _kDefaultTextColor,
        height: 24 / 16,
      ),
    );
  }
}

class Body3 extends StatelessWidget {
  const Body3({super.key, required this.value, this.color, this.bold = false});

  final String value;
  final Color? color;
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
        height: 18 / 15,
      ),
    );
  }
}

class Body4 extends StatelessWidget {
  const Body4({super.key, required this.value, this.color, this.bold = false});

  final String value;
  final Color? color;
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
      ),
    );
  }
}
