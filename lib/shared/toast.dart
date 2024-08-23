import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class Toast {
  static int duration = 2400; // ms

  static void show(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 105,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              padding: const EdgeInsets.fromLTRB(12, 12, 14, 12),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: ThemeColor.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(2, 2),
                  )
                ],
                color: ThemeColor.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/notification.svg'),
                  const SizedBox(width: 8),
                  Body3(
                    value: message,
                    color: ThemeColor.gray5,
                    bold: true,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(Duration(milliseconds: duration), () {
      overlayEntry.remove();
    });
  }
}
