import 'package:flutter/material.dart';
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
            Tab(
              child: SizedBox(
                width: 72,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _tabController.index == 0
                        ? SvgPicture.asset(
                            'assets/icons/emoji.svg',
                            colorFilter: ColorFilter.mode(
                              ThemeColor.primary,
                              BlendMode.srcIn,
                            ),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(width: 4),
                    const Text('이모지'),
                  ],
                ),
              ),
            ),
            Tab(
              child: SizedBox(
                width: 72,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _tabController.index == 1
                        ? SvgPicture.asset(
                            'assets/icons/talk.svg',
                            colorFilter: ColorFilter.mode(
                              ThemeColor.primary,
                              BlendMode.srcIn,
                            ),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(width: 4),
                    const Text('댓글'),
                  ],
                ),
              ),
            ),
          ]),
      body: TabBarView(controller: _tabController, children: const [
        Center(
          child: Body2(
            value: '이모지',
          ),
        ),
        Center(
          child: Body2(
            value: '이모지',
          ),
        ),
      ]),
    );
  }
}
