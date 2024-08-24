import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class FeedEmpty extends StatelessWidget {
  const FeedEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 66),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset('assets/images/empty.png', width: 140),
          const SizedBox(height: 16),
          Body2(
            value: '텅 비어 있어요..',
            color: ThemeColor.gray3,
            bold: true,
          )
        ],
      ),
    );
  }
}

class FeedError extends StatelessWidget {
  const FeedError({
    super.key,
    required this.pagingController,
  });

  final PagingController pagingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset('assets/images/empty.png', width: 140),
          const SizedBox(height: 16),
          Body2(
            value: '에러가 발생했어요..',
            color: ThemeColor.gray3,
            bold: true,
          ),
          const SizedBox(height: 16),
          TextButton(
              style: TextButton.styleFrom(
                elevation: 0,
                fixedSize: const Size.fromHeight(30),
                backgroundColor: ThemeColor.gray2,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              onPressed: () => {pagingController.refresh()},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Body4(
                  value: '다시 시도하기',
                  color: ThemeColor.gray5,
                  fontWeight: FontWeight.w600,
                ),
              ))
        ],
      ),
    );
  }
}
