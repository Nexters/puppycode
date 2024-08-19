import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:puppycode/shared/image.dart';
import 'package:puppycode/shared/styles/button.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';
import 'package:puppycode/shared/user.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: const Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          HomeTitle(),
          SizedBox(height: 20),
          Expanded(child: HomeContent()),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
  });

  Future getImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      Get.toNamed('/create', arguments: {
        'photoPath': pickedFile.path,
        'from': 'home',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    final user = userController.user.value;
    final hasWalkDone = user?.walkDone == true;

    return Stack(
      children: [
        SharedNetworkImage(
            url: user?.mainScreenImageUrl ?? 'assets/images/empty'),
        Positioned(
            left: 0,
            right: 0,
            height: 56,
            bottom: 32,
            child: DefaultTextButton(
                disabled: hasWalkDone,
                text: '',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/paw_small.svg',
                        width: 20,
                        colorFilter: ColorFilter.mode(
                            hasWalkDone ? ThemeColor.gray4 : ThemeColor.gray6,
                            BlendMode.srcIn)),
                    const SizedBox(width: 6),
                    Body1(
                      value: hasWalkDone ? '오늘도 산책 완료!' : '오늘 산책 인증하기',
                      bold: true,
                      color: hasWalkDone ? ThemeColor.gray4 : ThemeColor.gray6,
                    )
                  ],
                ),
                onPressed: () {
                  if (hasWalkDone) return;
                  getImage(ImageSource.camera);
                }))
      ],
    );
  }
}

class WeatherGuide extends StatelessWidget {
  const WeatherGuide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: ThemeColor.gray2)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                  color: ThemeColor.gray2,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ThemeColor.gray2)),
              child: SvgPicture.asset('assets/icons/weather_cloudy.svg'),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Body3(value: '나갈 때 물통을 챙겨주세요💦', bold: true),
                Body4(
                  value: '서울 31℃',
                  color: ThemeColor.gray4,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTitle extends StatelessWidget {
  const HomeTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Head3(value: '1시간 남았어요! 얼른 나가요 🐾'),
        SizedBox(height: 12),
        WeatherGuide(),
      ],
    );
  }
}
