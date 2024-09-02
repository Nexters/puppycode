import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:puppycode/apis/models/comment.dart';
import 'package:puppycode/apis/models/feed.dart';
import 'package:puppycode/apis/models/reaction.dart';
import 'package:puppycode/pages/feedDetails/reaction_contents.dart';
import 'package:puppycode/pages/feeds/feed_item.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/episode.dart';
import 'package:puppycode/shared/function/sharedAlertDialog.dart';
import 'package:puppycode/shared/function/sharedModalBottomSheet.dart';
import 'package:puppycode/shared/http.dart';
import 'package:puppycode/shared/states/user.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/toast.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';
import 'package:share_plus/share_plus.dart';

class FeedDetailPage extends StatefulWidget {
  const FeedDetailPage({super.key});

  @override
  State<FeedDetailPage> createState() => _FeedDetailPageState();
}

class _FeedDetailPageState extends State<FeedDetailPage> {
  final userController = Get.find<UserController>();
  Feed? feed;
  static String? link;
  String? feedId;

  @override
  void initState() {
    super.initState();
    feedId = Get.parameters['id'];
    _fetchFeedDetails(feedId);
  }

  void refetchData() {
    _fetchFeedDetails(feedId).then((_) {
      print('fetch 성공');
    });
  }

  Future<void> _fetchFeedDetails(id) async {
    try {
      final item = await HttpService.getOne('walk-logs/$id');

      setState(() {
        feed = Feed(item);
        link = 'Pawpaw://feed/$id';
      });
      // print(feedItems);
    } catch (error) {
      print('error: $error');
    }
  }

  Future<void> _deleteFeed(context, id) async {
    try {
      await HttpService.delete('walk-logs/$id', onDelete: () async {
        await userController.refreshData();
        Get.offAndToNamed('/');
      });
    } catch (error) {
      print('delete Feed erorr: $error');
    }
  }

  Future<void> _reportFeed(walkLogId, reason) async {
    try {
      await HttpService.post('walk-logs/report',
          body: {'reportedWalkLogId': walkLogId, 'reason': reason});
      print('게시글 신고');
    } catch (err) {
      print('report walkLog error: $err');
    }
  }

  void _showActionSheet(BuildContext ancestorContext) {
    showCupertinoModalPopup(
      context: ancestorContext,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          if (feed!.isWriter!)
            CupertinoActionSheetAction(
              onPressed: () {
                Get.back();
                Get.toNamed('/create', arguments: {
                  'id': feedId,
                });
              },
              child: Body2(value: '수정하기', color: ThemeColor.blue),
            ),
          CupertinoActionSheetAction(
            onPressed: () {
              Share.share(link!, subject: 'Pawpaw');
              Get.back();
            },
            child: Body2(value: '공유하기', color: ThemeColor.blue),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
              feed!.isWriter!
                  ? showSharedDialog(
                      context,
                      AlertDialogType.DELETE,
                      () {
                        _deleteFeed(context, feedId);
                      },
                    )
                  : showSharedDialog(
                      context,
                      AlertDialogType.REPORT,
                      () {
                        _reportFeed(feedId, '욕설').then(
                          (_) => {
                            Toast.show(ancestorContext, '신고를 완료했어요'),
                          },
                        );
                      },
                    );
            },
            child: Body2(
                value: feed!.isWriter! ? '삭제하기' : '신고하기',
                color: ThemeColor.error),
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (feed == null) return const Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: SharedAppBar(
        leftOptions: AppBarLeft(),
        centerOptions: AppBarCenter(
            label: feed!.name,
            caption: '${feed!.formattedCreatedAt} · ${feed!.walkTime}'),
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
                FeedPhoto(
                  photoUrl: feed!.photoUrl,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    FeedReactionButton(
                      refetch: refetchData,
                      comments: feed!.comments,
                      reactions: feed!.reactions,
                      walkLogId: feed!.id.toString(),
                      feedWriterId: feed!.writerId.toString(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Head3(value: feed!.title),
                const SizedBox(height: 16),
                if (feed?.episode.isNotEmpty == true || feed?.isWriter == true)
                  Episode(
                    content: feed!.episode,
                    isWriter: feed!.isWriter!,
                    id: feedId,
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
  final List<Comment> comments;
  final List<Reaction> reactions;
  final Function refetch;
  final String walkLogId;
  final String feedWriterId;

  const FeedReactionButton({
    required this.refetch,
    required this.comments,
    required this.reactions,
    required this.walkLogId,
    required this.feedWriterId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        sharedModalBottomSheet(
            context,
            ReactionContents(
              comments: comments,
              reactions: reactions,
              refetch: refetch,
              walkLogId: walkLogId,
              feedWriterId: feedWriterId,
            ),
            null,
            height: 640);
      },
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/emoji.svg',
            colorFilter: ColorFilter.mode(ThemeColor.gray4, BlendMode.srcIn),
          ),
          const SizedBox(width: 2),
          Body4(value: reactions.length.toString(), color: ThemeColor.gray4),
          const SizedBox(width: 16),
          SvgPicture.asset(
            'assets/icons/comment.svg',
            colorFilter: ColorFilter.mode(ThemeColor.gray4, BlendMode.srcIn),
          ),
          const SizedBox(width: 2),
          Body4(value: comments.length.toString(), color: ThemeColor.gray4),
        ],
      ),
    );
  }
}
