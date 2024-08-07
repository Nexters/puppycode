import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:puppycode/pages/feeds/feed_item.dart';

class FeedListView extends StatefulWidget {
  const FeedListView({super.key});

  @override
  _FeedListViewState createState() => _FeedListViewState();
}

class _FeedListViewState extends State<FeedListView> {
  static const _pageSize = 20;

  final PagingController<int, Feed> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      List<Feed> feedItems = [Feed(id: '1', name: '포포')];
      //final newItems = await RemoteApi.getFeedList(pageKey, _pageSize);
      final isLastPage = feedItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(feedItems);
      } else {
        final nextPageKey = pageKey + feedItems.length;
        _pagingController.appendPage(feedItems, nextPageKey);
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
