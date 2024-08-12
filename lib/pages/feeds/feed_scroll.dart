import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:puppycode/pages/feeds/feed_item.dart';
import 'package:puppycode/shared/http.dart';

class FeedListView extends StatefulWidget {
  const FeedListView({super.key});

  @override
  _FeedListViewState createState() => _FeedListViewState();
}

class _FeedListViewState extends State<FeedListView> {
  static const _limit = 5;

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
      final response = await HttpService.get('walk-logs', params: {
        'pageSize': '$_limit',
        'cursorId': cursor == 0 ? null : '$cursor'
      });
      List<dynamic> logs = response['walkLogList']; // res 추상화 서버에 요청
      List<Feed> feedItems = logs.map((item) => Feed(item)).toList();

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
  Widget build(BuildContext context) =>
      // Don't worry about displaying progress or error indicators on screen; the
      // package takes care of that. If you want to customize them, use the
      // [PagedChildBuilderDelegate] properties.
      RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: PagedListView<int, Feed>(
          shrinkWrap: true,
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Feed>(
            itemBuilder: (context, item, index) => FeedItem(
              item: item,
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
