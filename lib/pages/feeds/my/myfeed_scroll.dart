import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:puppycode/apis/models/monthly.dart';
import 'package:puppycode/pages/feeds/empty.dart';
import 'package:puppycode/pages/feeds/feed_item.dart';
import 'package:puppycode/shared/http.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/user.dart';

class MyFeedGridView extends StatefulWidget {
  const MyFeedGridView({super.key});

  @override
  MyFeedGridViewState createState() => MyFeedGridViewState();
}

class MyFeedGridViewState extends State<MyFeedGridView> {
  final PagingController<int, MyMontlyList> _pagingController =
      PagingController(firstPageKey: DateTime.now().month); // == firstCursor
  final userController = Get.find<UserController>();
  bool isLoaded = false;

  @override
  void initState() {
    _pagingController.addPageRequestListener((cursor) {
      _fetchPage(cursor);
    });
    super.initState();
  }

  Future<void> _fetchPage(int cursor) async {
    try {
      final monthlyItem =
          await HttpService.getOne('walk-logs/monthly', params: {
        'year': '2024',
        'month': '$cursor',
        'userId': userController.user.value!.id.toString()
      });

      MyMontlyList monthlyList = MyMontlyList(monthlyItem);

      final isLastPage = !monthlyList.hasNext;
      if (isLastPage) {
        isLoaded = true;
        _pagingController.appendLastPage([monthlyList]);
      } else {
        final nextCursor = monthlyList.nextMonth;
        _pagingController.appendPage([monthlyList], nextCursor);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: PagedListView<int, MyMontlyList>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<MyMontlyList>(
            noItemsFoundIndicatorBuilder: (context) => const FeedEmpty(),
            itemBuilder: (context, monthly, index) => Column(
              children: isLoaded &&
                      _pagingController.itemList?.first.items.isEmpty == true
                  ? [const FeedEmpty()]
                  : [
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                            color: ThemeColor.gray2,
                            borderRadius: BorderRadius.circular(20)),
                        child: Body3(
                          value: '${monthly.month}월 · ${monthly.count}개의 일지',
                          color: ThemeColor.gray5,
                          bold: true,
                        ),
                      ),
                      GridView(
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 170 / 270,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 16,
                        ),
                        children: monthly.items
                            .map((item) =>
                                FeedItem(item: item, isListView: false))
                            .toList(),
                      ),
                      const SizedBox(height: 14)
                    ],
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
