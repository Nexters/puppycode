// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/styles/color.dart';

enum AlertDialogType { REPORT, DELETE, LOGOUT, WITHDRAWAL, DELFRIEND }

enum ReportType { COMMENT, FEED, USER }

Map<AlertDialogType, String> confirmLabel = {
  AlertDialogType.REPORT: '신고',
  AlertDialogType.DELETE: '삭제',
  AlertDialogType.LOGOUT: '로그아웃',
  AlertDialogType.WITHDRAWAL: '회원탈퇴',
  AlertDialogType.DELFRIEND: '친구 끊기',
};

Map<AlertDialogType, String> title = {
  AlertDialogType.REPORT: '게시글 신고',
  AlertDialogType.DELETE: '산책 일지를 삭제하시겠어요?',
  AlertDialogType.LOGOUT: '로그아웃',
  AlertDialogType.WITHDRAWAL: '회원탈퇴',
  AlertDialogType.DELFRIEND: '정말 친구를 끊으실건가요?',
};

Map<AlertDialogType, String> alertContents = {
  AlertDialogType.REPORT: '해당 게시글을 신고하시겠어요?',
  AlertDialogType.DELETE: '삭제 후 해당 날짜의 일지를 되돌릴 수 없어요.',
  AlertDialogType.LOGOUT: "'pawpaw'와 잠시 멀어져도 괜찮아요\n다시 돌아오실거죠?",
  AlertDialogType.WITHDRAWAL: '정말 계정을 삭제하시겠습니까?',
  AlertDialogType.DELFRIEND: '지금 멀어져도 친구 코드만 있다면\n언제든 다시 친구할 수 있어요',
};

Future<dynamic> showSharedDialog(
    BuildContext context, AlertDialogType alertType, VoidCallback onConfirm) {
  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title[alertType]!),
        content: Text(alertContents[alertType]!),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Get.back();
            },
            child: Text(
              '취소',
              style: TextStyle(color: ThemeColor.blue),
            ),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              onConfirm();
              Get.back();
            },
            child: Text(
              confirmLabel[alertType]!,
              style: TextStyle(
                  color: alertType == AlertDialogType.LOGOUT ||
                          alertType == AlertDialogType.WITHDRAWAL
                      ? ThemeColor.blue
                      : ThemeColor.error),
            ),
          ),
        ]),
  );
}
