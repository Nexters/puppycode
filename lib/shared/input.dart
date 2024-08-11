import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final bool? showClearIcon;
  final int? maxLength;

  const TextInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.showClearIcon = true,
    this.maxLength,
  });

  static _getInputBorderStyle(bool focus) {
    return OutlineInputBorder(
      borderSide:
          BorderSide(color: focus ? ThemeColor.primary : ThemeColor.gray2),
      borderRadius: BorderRadius.circular(20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => {if (onChanged != null) onChanged!(value)},
      maxLength: maxLength,
      controller: controller,
      decoration: InputDecoration(
          counterText: '',
          hintText: hintText,
          focusedBorder: _getInputBorderStyle(true),
          enabledBorder: _getInputBorderStyle(false),
          contentPadding: const EdgeInsets.all(16),
          labelStyle: BodyTextStyle.getBody1Style(bold: true),
          hintStyle: BodyTextStyle.getBody1Style(color: ThemeColor.gray4),
          suffixIcon: controller.text.isNotEmpty && showClearIcon == true
              ? GestureDetector(
                  onTap: () => {
                    controller.clear(),
                    if (onChanged != null) onChanged!('')
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      'assets/icons/clear.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                )
              : null),
    );
  }
}

class TextInputWithBottomSheet extends StatefulWidget {
  final String hintText;
  final VoidCallback onTap;
  final String? value;

  const TextInputWithBottomSheet({
    super.key,
    required this.hintText,
    required this.onTap,
    this.value,
  });

  @override
  State<TextInputWithBottomSheet> createState() =>
      _TextInputWithBottomSheetState();
}

class _TextInputWithBottomSheetState extends State<TextInputWithBottomSheet> {
  bool _isFocused = false;

  Widget _createLocationSelectContainer(BuildContext context) {
    var bottom = MediaQuery.of(context).viewInsets.bottom;

    return BottomSheet(
      onClosing: () => {},
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 30, bottom: bottom, left: 16, right: 16),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Container(
                child: const Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              setState(() {
                _isFocused = true;
              }),
              showModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      _createLocationSelectContainer(context)).whenComplete(() {
                setState(() {
                  _isFocused = false;
                });
              })
            },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: _isFocused ? ThemeColor.primary : ThemeColor.gray2)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Body1(
                value: widget.hintText,
                color:
                    widget.value == null ? ThemeColor.gray4 : ThemeColor.gray6,
              ),
              RotatedBox(
                quarterTurns: 3,
                child: SvgPicture.asset('assets/icons/chevron_left.svg',
                    colorFilter:
                        ColorFilter.mode(ThemeColor.gray3, BlendMode.srcIn)),
              )
            ],
          ),
        ));
  }
}
