import 'package:flutter/material.dart';

class Body1 extends StatelessWidget {
  const Body1({super.key, required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: -1,
        color: Color(0xFF1E2022),
      ),
    );
  }
}
