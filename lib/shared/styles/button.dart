import 'package:flutter/material.dart';

class TextButtonColor extends WidgetStateColor {
  const TextButtonColor() : super(_defaultColor);

  static const int _defaultColor = 0xFFF000;
  static const int _pressedColor = 0xdeadbeef;

  // 왜 적용이 아될까?
  @override
  Color resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.pressed)) {
      return const Color(TextButtonColor._pressedColor);
    }
    return const Color(TextButtonColor._defaultColor);
  }
}

class TextButtonStyle extends ButtonStyle {
  static ButtonStyle getStyle() {
    return TextButton.styleFrom(
      backgroundColor: const TextButtonColor(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
    );
  }
}

class DefaultTextButton extends TextButton {
   DefaultTextButton({
    super.key,
    required String text,
    required VoidCallback onPressed,
  }) : super(
    onPressed: onPressed,
    style: defaultStyle,
    child: Text(text, style: textStyle,),
  );

  static final ButtonStyle defaultStyle = TextButtonStyle.getStyle();
  static const TextStyle textStyle = TextStyle(color: Colors.black);
}