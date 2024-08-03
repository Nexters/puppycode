import 'package:flutter/material.dart';

class TextButtonColor extends WidgetStateColor {
  TextButtonColor(this.defaultValue) : super(0x111111);

  int defaultValue = 0xA0A8AE;
  Color defaultColor = Colors.yellow;
  Color pressedColor = Colors.yellowAccent;

// 왜 적용이 아될까?
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
        backgroundColor: disabled == true ? Colors.grey : Colors.black,
        //backgroundColor: disabled == false ? Colors.grey : TextBduttonColor(123),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
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
          child: Text(
            text,
            style: textStyle,
          ),
        );

  static const getStyle = TextButtonStyle.getStyle;
  static const TextStyle textStyle = TextStyle(color: Colors.white);
}
