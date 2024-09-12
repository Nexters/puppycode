import 'package:flutter/material.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class TextButtonColor extends WidgetStateColor {
  TextButtonColor() : super(defaultColor.value);

  static Color defaultColor = ThemeColor.primary;
  static Color pressedColor = ThemeColor.primaryPressed; // 임시값

  @override
  Color resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.pressed)) {
      return pressedColor;
    }
    return defaultColor;
  }
}

class TextButtonStyle extends ButtonStyle {
  static ButtonStyle getStyle({bool? disabled, Color? backgroundColor}) {
    return TextButton.styleFrom(
        elevation: 0,
        fixedSize: const Size.fromHeight(56),
        backgroundColor: disabled == true
            ? ThemeColor.gray2
            : backgroundColor ?? TextButtonColor(),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        overlayColor:
            disabled == true ? Colors.transparent : ThemeColor.primaryPressed);
  }
}

class DefaultTextButton extends TextButton {
  DefaultTextButton({
    super.key,
    required String text,
    required VoidCallback onPressed,
    bool? disabled,
    ButtonStyle? style,
    Widget? child,
    Color? color,
  }) : super(
          onPressed: disabled == true ? null : onPressed,
          style: style ?? getStyle(disabled: disabled),
          child: child ??
              Body1(
                value: text,
                bold: true,
                color: disabled == true ? ThemeColor.gray4 : null,
              ),
        );

  static const getStyle = TextButtonStyle.getStyle;
}

class DefaultCloseButton extends DefaultTextButton {
  DefaultCloseButton({
    super.key,
    required super.onPressed,
  }) : super(
            text: '닫기',
            style: TextButtonStyle.getStyle(backgroundColor: ThemeColor.gray2),
            child: const Body1(
              value: '닫기',
              bold: true,
            ));
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
          child: Body1(
            value: text,
            bold: true,
            color: disabled == true ? ThemeColor.gray4 : null,
          ),
        );

  static const getStyle = TextButtonStyle.getStyle;
}
