import 'package:flutter/material.dart';
import 'package:puppycode/shared/styles/color.dart';

Future<dynamic> sharedModalBottomSheet(
    BuildContext context, Widget widget, VoidCallback? onComplete) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
      final double modalHeight = keyboardHeight > 0 ? 660 : 480;

      return Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        height: modalHeight,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 63,
                decoration: BoxDecoration(
                  color: ThemeColor.gray3,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: widget, // 여기 위젯 넣으면 됩니댜 ,,
              ),
            ],
          ),
        ),
      );
    },
  ).whenComplete(() {
    // 요거 말하는걸까용..
  });
}