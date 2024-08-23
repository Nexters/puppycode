import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:puppycode/pages/feeds/empty.dart';
import 'package:puppycode/pages/feeds/feed_item.dart';
import 'package:puppycode/shared/feed.dart';
import 'package:puppycode/shared/http.dart';
import 'package:puppycode/apis/models/feed.dart';

class FeedListView extends StatefulWidget {
  const FeedListView({super.key, this.focusedUserId});

  final int? focusedUserId;

  @override
  FeedListViewState createState() => FeedListViewState();
}

class FeedListViewState extends State<FeedListView> {
  final ValueNotifier<int>? focusedUserId = ValueNotifier<int>(0);
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

  @override
  void didUpdateWidget(FeedListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusedUserId != widget.focusedUserId) {
      _pagingController.refresh(); //
    }
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
      print(error);
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => CustomRefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        builder: (context, child, controller) => PawpawRefreshBuilder(
            context, child, controller,
            text: '친구의 소식을 불러오고 있어요!'),
        child: PagedListView<int, Feed>(
          shrinkWrap: true,
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Feed>(
            noItemsFoundIndicatorBuilder: (context) => const FeedEmpty(),
            itemBuilder: (context, item, index) => FeedItem(
              item: item,
              isListView: true,
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
