import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/pages/feedDetails/reaction_tab_view.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class ReactionTabBar extends StatefulWidget {
  final int selectedTabIdx;
  const ReactionTabBar({
    super.key,
    required this.selectedTabIdx,
  });

  @override
  State<ReactionTabBar> createState() => _ReactionTabBarState();
}

class _ReactionTabBarState extends State<ReactionTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2, vsync: this, initialIndex: widget.selectedTabIdx);

    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  static _getTabBarTextStyle(bool focus) {
    return BodyTextStyle.getBody3Style(
      bold: true,
      color: focus ? ThemeColor.gray5 : ThemeColor.gray3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelPadding: const EdgeInsets.symmetric(horizontal: 3),
          indicatorColor: ThemeColor.primary,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: _getTabBarTextStyle(true),
          unselectedLabelColor: ThemeColor.gray3,
          unselectedLabelStyle: _getTabBarTextStyle(false),
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
      body: ReactionTabView(
        tabController: _tabController,
        commentController: _commentController,
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
