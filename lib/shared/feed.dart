import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class PawpawRefreshBuilder extends StatelessWidget {
  const PawpawRefreshBuilder(this.context, this.child, this.controller,
      {super.key, required this.text, this.threshold = 0});

  final BuildContext context;
  final Widget child;
  final IndicatorController controller;
  final String text;
  final double threshold;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        if (controller.value > threshold)
          Positioned(
            top: 5,
            child: Opacity(
              opacity: 1,
              child: Image.asset(
                'assets/images/refresh.png',
                width: 70,
                height: 62.8,
              ),
            ),
          ),
        if (controller.value > threshold)
          Positioned(
              top: 73,
              child: Body4(
                value: text,
                color: ThemeColor.gray4,
              )),
        Transform.translate(
          offset: Offset(0, 100.0 * controller.value),
          child: child,
        ),
      ],
    );
  }
}
