import 'package:flutter/material.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class ReactionCommentListItem extends StatelessWidget {
  // final Image profileImage;
  final String userName;
  final String comment;

  const ReactionCommentListItem({
    super.key,
    // required this.profileImage,
    required this.userName,
    required this.comment,
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
              Body3(value: userName, bold: true),
              const SizedBox(height: 2),
              SizedBox(
                width: MediaQuery.of(context).size.width - 90,
                child: Body3(value: comment),
                // softWrap 써도 너비는 지정해줘야하는 듯..
                // child: Text(
                //   comment,
                //   softWrap: true,
                //   style: BodyTextStyle.getBody3Style(),
                // ),
              )
            ],
          )
        ],
      ),
    );
  }
}