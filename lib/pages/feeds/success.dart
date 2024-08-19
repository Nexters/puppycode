import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/nav_bar.dart';
import 'package:puppycode/shared/styles/button.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';

// 피드 생성인 경우에만 이동하는 페이지 (수정인 경우 오지 않음)
class FeedCreateSuccessPage extends StatelessWidget {
  const FeedCreateSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    var isFromFeed = Get.arguments['from'] == 'feed';
    var feedId = Get.arguments['feedId'];

    return Scaffold(
      body: Center(
          child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Column(children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Head1(value: '오늘도 산책 완료')),
              Body1(value: '귀찮음을 이겨냈으니 100점 반려인이네요')
            ]),
            Container(
              margin: const EdgeInsets.only(top: 40, bottom: 12),
              height: 190,
              color: Colors.black12,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/create_success.png'))),
            ),
            FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(228, 234, 238, 0.4)),
                onPressed: () => {
                      // 에피소드 적기
                    },
                child: const Body2(
                  value: '에피소드 적기',
                ))
          ],
        ),
      )),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                  child: DefaultCloseButton(
                      onPressed: () => {
                            Get.toNamed('/', arguments: {
                              'tab': isFromFeed ? NavTab.feed : NavTab.home
                            })
                          })),
              const SizedBox(width: 8),
              Expanded(
                  child: DefaultTextButton(
                      text: '산책일지 보러가기',
                      onPressed: () => {Get.toNamed('/feed/$feedId')})),
            ],
          ),
        ),
      ),
    );
  }
}
