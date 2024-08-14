import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:puppycode/pages/feeds/feed_item.dart';
import 'package:puppycode/pages/feedDetails/reaction_tab_bar.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/function/sharedModalBottomSheet.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';
import 'package:share/share.dart';

class FeedDetailPage extends StatefulWidget {
  const FeedDetailPage({super.key});

  @override
  State<FeedDetailPage> createState() => _FeedDetailPageState();
}

class _FeedDetailPageState extends State<FeedDetailPage> {
  String tmpLink = 'abcd';
  bool isWriter = false; // 상상코딩이 되지 않아요 ..

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          if (isWriter)
            CupertinoActionSheetAction(
              onPressed: () {
                // 수정하기
                Get.back();
              },
              child: Body2(value: '수정하기', color: ThemeColor.blue),
            ),
          CupertinoActionSheetAction(
            onPressed: () {
              Share.share(tmpLink); // 무엇을 공유하지요? => 링크 ?
              Get.back();
            },
            child: Body2(value: '공유하기', color: ThemeColor.blue),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
            },
            child: Body2(
                value: isWriter ? '삭제하기' : '신고하기', color: ThemeColor.error),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
            },
            child: Body2(value: '취소하기', color: ThemeColor.blue)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppBar(
        leftOptions: AppBarLeft(),
        centerOptions: AppBarCenter(label: '포포', caption: '1시간 전 · 20분~40분 산책'),
        rightOptions: AppBarRight(icons: [
          RightIcon(name: 'more', onTap: () => _showActionSheet(context))
        ]),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FeedPhoto(),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    FeedReactionButton(idx: 0, svg: 'emoji', count: 3),
                    FeedReactionButton(idx: 1, svg: 'talk', count: 3),
                  ],
                ),
                const SizedBox(height: 16),
                const Head3(value: '자다가 산책 가자니까 벌떡 일어나는거 봐'),
                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.only(bottom: 18),
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
                                  ThemeColor.gray4, BlendMode.srcIn),
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
      ),
    );
  }
}

class FeedReactionButton extends StatelessWidget {
  final int idx;
  final String svg;
  final int count;

  const FeedReactionButton({
    required this.idx,
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
          sharedModalBottomSheet(
              context, ReactionTabBar(selectedTabIdx: idx), null);
        },
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/$svg.svg',
              colorFilter: ColorFilter.mode(ThemeColor.gray4, BlendMode.srcIn),
            ),
            const SizedBox(width: 2),
            Body4(value: '$count', color: ThemeColor.gray4),
          ],
        ),
      ),
    );
  }
}
