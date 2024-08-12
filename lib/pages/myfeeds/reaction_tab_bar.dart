import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class ReactionTabBar extends StatefulWidget {
  const ReactionTabBar({super.key});

  @override
  State<ReactionTabBar> createState() => _ReactionTabBarState();
}

class _ReactionTabBarState extends State<ReactionTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelPadding: const EdgeInsets.symmetric(horizontal: 3),
          indicatorColor: ThemeColor.primary,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle:
              BodyTextStyle.getBody3Style(bold: true, color: ThemeColor.gray5),
          unselectedLabelColor: ThemeColor.gray3,
          unselectedLabelStyle:
              BodyTextStyle.getBody3Style(bold: true, color: ThemeColor.gray3),
          tabs: [
            CustomTab(
              tabController: _tabController,
              index: 0,
              label: '이모지',
              iconPath: 'emoji',
            ),
            CustomTab(
              tabController: _tabController,
              index: 1,
              label: '댓글',
              iconPath: 'talk',
            ),
          ]),
      body: TabBarView(controller: _tabController, children: const [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ReactionEmojiListItem(emoji: '😆', userName: '푸름이'),
                  ReactionEmojiListItem(emoji: '😍', userName: '앙꼬'),
                  ReactionEmojiListItem(emoji: '😍', userName: '샛별이'),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ReactionCommentListItem(
                      userName: '푸름이', comment: 'ㅋㅋㅋ우리집 강아지도 산책만 들으면 환장을 함'),
                  ReactionCommentListItem(
                      userName: '샛별이', comment: '우리집 강아지가 젤 귀여움 ☀︎'),
                  ReactionCommentListItem(
                      userName: '앙꼬',
                      comment: '미쳤다 저정도 정전기라면 모든 것을 이겨낼 수 있지 않을까 캬캬캬캬캬캬캬캬캬캬')
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class ReactionCommentListItem extends StatelessWidget {
  // final Image profileImage;
  final String userName;
  final String comment;

  const ReactionCommentListItem({
    super.key,
    // required this.profileImage,
    required this.userName,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: ThemeColor.gray2,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Body3(value: userName, bold: true),
              const SizedBox(height: 2),
              SizedBox(
                width: MediaQuery.of(context).size.width -
                    93, // 지정해둔 width를 넘으면 개행시킬 수 있는 방법이 있나요 ..?
                child: Body3(value: comment),
              )
            ],
          )
        ],
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final TabController _tabController;
  final int index;
  final String label;
  final String iconPath;

  const CustomTab({
    super.key,
    required TabController tabController,
    required this.index,
    required this.label,
    required this.iconPath,
  }) : _tabController = tabController;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: SizedBox(
        width: 72,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _tabController.index == index
                ? SvgPicture.asset(
                    'assets/icons/$iconPath.svg',
                    colorFilter: ColorFilter.mode(
                      ThemeColor.primary,
                      BlendMode.srcIn,
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class ReactionEmojiListItem extends StatelessWidget {
  final String emoji;
  final String userName;

  const ReactionEmojiListItem({
    super.key,
    required this.emoji,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                    color: ThemeColor.gray2,
                    borderRadius: BorderRadius.circular(21.25)),
              ),
              Text(
                emoji,
                style: const TextStyle(
                    fontSize: 21.25,
                    letterSpacing: -0.012 * 21.25,
                    height: 29.8 / 21.25),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Body1(value: userName),
        ],
      ),
    );
  }
}
