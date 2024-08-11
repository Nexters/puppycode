import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/pages/feeds/feed_item.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/caption.dart';
import 'package:puppycode/shared/typography/head.dart';

class MyFeedPage extends StatefulWidget {
  const MyFeedPage({super.key});

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Body1(value: '포포', bold: true),
            Caption(
              value: '1시간 전',
              color: ThemeColor.gray4,
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_sharp),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FeedPhoto(),
              const SizedBox(height: 12),
              const Row(
                children: [
                  FeedReactionButton(svg: 'emoji', count: 3),
                  FeedReactionButton(svg: 'talk', count: 3),
                ],
              ),
              const SizedBox(height: 20),
              // 네이밍이 애매해서 아직 위젯으로 못 뺌..
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ThemeColor.primary.withOpacity(0.15)),
                height: 28,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Caption(
                      value: '20분~40분 산책', color: ThemeColor.primaryPressed),
                ),
              ),
              const SizedBox(height: 8),
              const Head3(value: '자다가 산책 가자니까 벌떡 일어나는거 봐'),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: ThemeColor.gray2, width: 1.2)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/episode.svg',
                            colorFilter: ColorFilter.mode(
                                ThemeColor.gray3, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 4),
                          const Body2(value: '오늘의 에피소드', bold: true)
                        ],
                      ),
                      const SizedBox(height: 8),
                      Body3(
                        value:
                            '날이 너무 더워서 에어컨 틀어놓고 잠깐 나간 사이에 잠든 포포🐕 귀여워... 산책갈까? 하니까 바로 벌떡!!!ㅋㅋ',
                        color: ThemeColor.gray5,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FeedReactionButton extends StatelessWidget {
  final String svg;
  final int count;

  const FeedReactionButton({
    required this.svg,
    required this.count,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            builder: (BuildContext context) {
              return Container(
                height: 480,
                width: 390, // width 수정 예정
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
              );
            },
          );
        },
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/$svg.svg',
              colorFilter: ColorFilter.mode(ThemeColor.gray3, BlendMode.srcIn),
            ),
            const SizedBox(width: 2),
            Body4(value: '$count', color: ThemeColor.gray3),
          ],
        ),
      ),
    );
  }
}
