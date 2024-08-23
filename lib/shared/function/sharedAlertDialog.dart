import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

Future<dynamic> sharedAlertDialog(
    BuildContext context,
    String title,
    String content,
    String leftActionTitle,
    String rightActionTitle,
    VoidCallback leftAction,
    VoidCallback rightAction) {
  return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('로그아웃'),
            content: const Text("\n'pawpaw'와 잠시 멀어져도 괜찮아요\n다시 돌아오실거죠?"),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Get.back();
                },
                child: const Text('취소'),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Get.back();
                },
                child: const Text('로그아웃'),
              )
            ],
          ));
}
