import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/caption.dart';

class ReactionCommentListItem extends StatelessWidget {
  // final Image profileImage;
  final String userName;
  final String comment;
  final bool isFeedWriter; // api 연결 후 수정

  const ReactionCommentListItem({
    super.key,
    // required this.profileImage,
    required this.userName,
    required this.comment,
    this.isFeedWriter = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: ThemeColor.gray2,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Body3(value: userName, bold: true),
                  const SizedBox(width: 6),
                  if (isFeedWriter) const Caption(value: '작성자'),
                ],
              ),
              const SizedBox(height: 2),
              SizedBox(
                width: MediaQuery.of(context).size.width - 120,
                child: Body3(value: comment),
              )
            ],
          ),
          SvgPicture.asset(
            'assets/icons/details.svg',
            colorFilter: ColorFilter.mode(ThemeColor.gray3, BlendMode.srcIn),
            width: 20,
            height: 20,
          ),
        ],
      ),
    );
  }
}
