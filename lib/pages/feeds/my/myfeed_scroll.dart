import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:puppycode/pages/feeds/feed_item.dart';
import 'package:puppycode/shared/http.dart';

class MyFeedGridView extends StatefulWidget {
  const MyFeedGridView({super.key});

  @override
  MyFeedGridViewState createState() => MyFeedGridViewState();
}

class MyFeedGridViewState extends State<MyFeedGridView> {
  static const _limit = 10;

  final PagingController<int, Feed> _pagingController =
      PagingController(firstPageKey: 0); // == firstCursor

  @override
  void initState() {
    _pagingController.addPageRequestListener((cursor) {
      _fetchPage(cursor);
    });
    super.initState();
  }

  Future<void> _fetchPage(int cursor) async {
    try {
      final items = await HttpService.get('walk-logs', params: {
        'pageSize': '$_limit',
        'cursorId': cursor == 0 ? null : '$cursor'
      });
      List<Feed> feedItems = items.map((item) => Feed(item)).toList();

      final isLastPage = feedItems.length < _limit;
      if (isLastPage) {
        _pagingController.appendLastPage(feedItems);
      } else {
        final nextCursor = feedItems.last.id;
        _pagingController.appendPage(feedItems, nextCursor);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: PagedGridView<int, Feed>(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          shrinkWrap: true,
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Feed>(
            itemBuilder: (context, item, index) => FeedItem(
              item: item,
              isListView: false,
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
