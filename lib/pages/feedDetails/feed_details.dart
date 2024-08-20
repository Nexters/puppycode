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
import 'package:puppycode/shared/function/sharedModalBottomSheet.dart';
import 'package:puppycode/shared/http.dart';
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
  String tmpLink = 'abcd'; // 공유할 현재 스크린 주소 => ?

  Feed? feed;

  @override
  void initState() {
    super.initState();
    _fetchFeedDetails(Get.parameters['id']);
  }

  Future<void> _fetchFeedDetails(id) async {
    try {
      final item = await HttpService.getOne('walk-logs/$id');

      setState(() {
        feed = Feed(item);
      });
      // print(feedItems);
    } catch (error) {
      print('error: $error');
    }
  }

  Future<void> _deleteFeed(id) async {
    try {
      await HttpService.delete('walk-logs/$id');
    } catch (error) {
      print('delete Feed erorr: $error');
    }
  }

  void onReportFeed() {
    // TODO : 신고하기
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          if (feed!.isWriter)
            CupertinoActionSheetAction(
              onPressed: () {
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
              feed!.isWriter
                  ? _deleteFeed(Get.parameters['id'])
                  : onReportFeed();
            },
            child: Body2(
                value: feed!.isWriter ? '삭제하기' : '신고하기',
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
                      comments: feed!.comments,
                      reactions: feed!.reactions,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Head3(value: feed!.title),
                const SizedBox(height: 16),
                Episode(
                  content: feed!.episode,
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

  const FeedReactionButton({
    required this.comments,
    required this.reactions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        sharedModalBottomSheet(context,
            ReactionContents(comments: comments, reactions: reactions), null,
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
            'assets/icons/talk.svg',
            colorFilter: ColorFilter.mode(ThemeColor.gray4, BlendMode.srcIn),
          ),
          const SizedBox(width: 2),
          Body4(value: comments.length.toString(), color: ThemeColor.gray4),
        ],
      ),
    );
  }
}
