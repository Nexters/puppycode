import 'package:flutter/cupertino.dart';
import 'package:puppycode/shared/styles/color.dart';

Future<dynamic> sharedAlertDialog(
    BuildContext context,
    String title,
    String content,
    String leftActionTitle,
    String rightActionTitle,
    VoidCallback leftAction,
    VoidCallback rightAction,
    {bool? isDestructive = false}) {
  return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  leftAction();
                },
                child: Text(
                  leftActionTitle,
                  style: TextStyle(color: ThemeColor.blue),
                ),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                isDestructiveAction: isDestructive!,
                onPressed: () {
                  rightAction();
                },
                child: Text(
                  rightActionTitle,
                  style: isDestructive
                      ? TextStyle(color: ThemeColor.error)
                      : TextStyle(color: ThemeColor.blue),
                ),
              )
            ],
          ));
}
