import 'package:flutter/material.dart';
import 'package:puppycode/shared/typography.dart';

class TextButtonColor extends WidgetStateColor {
  TextButtonColor() : super(defaultColor.value);

  static Color defaultColor = const Color(0xFF36DBBF);
  static Color pressedColor = const Color.fromARGB(255, 45, 170, 149); // 임시값

  @override
  Color resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.pressed)) {
      return pressedColor;
    }
    return defaultColor;
  }
}

class TextButtonStyle extends ButtonStyle {
  static ButtonStyle getStyle({bool? disabled}) {
    return TextButton.styleFrom(
      fixedSize: const Size.fromHeight(56),
      backgroundColor: disabled == true ? Colors.grey : TextButtonColor(),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }
}

class DefaultTextButton extends TextButton {
  DefaultTextButton({
    super.key,
    required String text,
    required VoidCallback onPressed,
    bool? disabled,
  }) : super(
          onPressed: onPressed,
          style: getStyle(disabled: disabled),
          child: Body1(value: text),
        );

  static const getStyle = TextButtonStyle.getStyle;
}

class DefaultElevatedButton extends ElevatedButton {
  DefaultElevatedButton({
    super.key,
    required String text,
    required VoidCallback onPressed,
    bool? disabled,
  }) : super(
          onPressed: onPressed,
          style: getStyle(disabled: disabled),
          child: Body1(value: text),
        );

  static const getStyle = TextButtonStyle.getStyle;
}
