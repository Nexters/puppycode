import 'package:flutter/material.dart';

class ButtonColor extends WidgetStateColor {
  const ButtonColor() : super(_defaultColor);

  static const int _defaultColor = 0xA0A8AE;
  static const int _pressedColor = 0xdeadbeef;

  @override
  Color resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.pressed)) {
      return const Color(_pressedColor);
    }
    return const Color(_defaultColor);
  }
}
