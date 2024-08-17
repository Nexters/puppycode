import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class PhotoPreviewPage extends StatelessWidget {
  const PhotoPreviewPage({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: Stack(alignment: Alignment.center, children: [
          Container(
            margin: const EdgeInsets.only(bottom: 48),
            child: AspectRatio(
              aspectRatio: 0.75,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Image.file(File(imagePath)),
                  )),
            ),
          ),
          Positioned(
              top: 15,
              child: Body1(
                value: '산책 기록하기',
                color: ThemeColor.white,
                bold: true,
              )),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => {Get.back()},
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: SvgPicture.asset(
                        'assets/icons/close.svg',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {Get.toNamed('/create', arguments: {})},
                    child: SvgPicture.asset('assets/icons/camera_complete.svg'),
                  ),
                  const SizedBox(
                    width: 40,
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
