import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class SharedBanner extends StatelessWidget {
  const SharedBanner({
    super.key,
    required this.mainText,
    required this.subText,
    required this.onClick,
  });

  final String mainText;
  final String subText;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(2, 2),
            )
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: ThemeColor.gray2,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ThemeColor.gray2),
              ),
              //child: SvgPicture.asset(''),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Body2(value: mainText, bold: true),
                  const SizedBox(height: 2),
                  Body4(
                    value: subText,
                    color: ThemeColor.gray5,
                  )
                ],
              ),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: SvgPicture.asset(
                'assets/icons/chevron_left.svg',
              ),
            )
          ],
        ),
      ),
    );
  }
}
