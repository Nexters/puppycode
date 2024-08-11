import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/styles/button.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        children: [
          const HomeTitle(),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 24, bottom: 20),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 20),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(228, 234, 238, 0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            height: 400,
            child: const HomeContent(),
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            width: MediaQuery.of(context).size.width - 16 * 2 - 20 * 2,
            height: 56,
            bottom: 0,
            child:
                DefaultTextButton(
                text: '',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/paw_small.svg',
                        width: 20,
                        colorFilter: ColorFilter.mode(
                            ThemeColor.black, BlendMode.srcIn)),
                    const SizedBox(width: 6),
                    const Body1(
                      value: '오늘 산책 인증하기',
                      bold: true,
                    )
                  ],
                ),
                onPressed: () => {Get.toNamed('/create')}))
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
