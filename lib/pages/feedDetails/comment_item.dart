import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:puppycode/apis/models/comment.dart';
import 'package:puppycode/shared/http.dart';
import 'package:puppycode/shared/image.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/toast.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/caption.dart';

class ReactionCommentListItem extends StatefulWidget {
  final Function refetch;
  final Comment comment;
  final String feedWriterId;

  const ReactionCommentListItem({
    super.key,
    required this.refetch,
    required this.comment,
    required this.feedWriterId,
  });

  @override
  State<ReactionCommentListItem> createState() =>
      _ReactionCommentListItemState();
}

class _ReactionCommentListItemState extends State<ReactionCommentListItem> {
  Future<void> _deleteComment(context, id) async {
    try {
      await HttpService.delete(
        'walk-logs/comments/$id',
        onDelete: () => {widget.refetch(), Get.back()},
      ).then(
        (_) => {
          Toast.show(context, '삭제를 완료했어요'),
        },
      );
    } catch (error) {}
  }

  Future<void> _reportComment(context, reportedCommentId, reason) async {
    try {
      await HttpService.post('walk-logs/comments/report',
              body: {'reportedCommentId': reportedCommentId, 'reason': reason})
          .then(
        (_) => {
          Toast.show(context, '신고를 완료했어요'),
        },
      );
    } catch (err) {}
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              widget.comment.isWriter
                  ? [
                      _deleteComment(context, widget.comment.id),
                      Get.back(),
                    ]
                  : [
                      _reportComment(context, widget.comment.id, '욕설'),
                      Get.back(),
                    ];
            },
            child: Body2(
                value: widget.comment.isWriter ? '삭제하기' : '신고하기',
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
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: ThemeColor.gray2,
              borderRadius: BorderRadius.circular(100),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: UserNetworkImage(
                  url: widget.comment.writerProfileUrl, width: 42, height: 42),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Body4(
                    value: widget.comment.writerName,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                    maxLength: 10,
                  ),
                  const SizedBox(width: 6),
                  if (widget.comment.writerId.toString() == widget.feedWriterId)
                    const Caption(value: '작성자'),
                ],
              ),
              const SizedBox(height: 2),
              SizedBox(
                width: MediaQuery.of(context).size.width - 120,
                child: Body3(value: widget.comment.content),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              _showActionSheet(context);
            },
            child: SvgPicture.asset(
              'assets/icons/more.svg',
              colorFilter: ColorFilter.mode(ThemeColor.gray3, BlendMode.srcIn),
              width: 20,
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}
