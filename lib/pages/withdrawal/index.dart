import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/function/sharedAlertDialog.dart';
import 'package:puppycode/shared/http.dart';
import 'package:puppycode/shared/styles/button.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  static const storage = FlutterSecureStorage();
  List<bool> selectedReasons = [false, false, false, false];

  void _onSelectedReason(int idx, bool isSelected) {
    setState(() {
      selectedReasons[idx] = isSelected;
    });
  }

  bool _isAnyReasonSelected() {
    return selectedReasons.any((selected) => selected);
  }

  void logout() async {
    await storage.delete(key: 'authToken');
    Get.offNamed('/login');
  }

  Future<void> _deleteUser() async {
    try {
      await HttpService.delete('users').then((_) => {
            logout(),
          });
      print('회원 탈퇴 완료');
    } catch (err) {
      print('deleteUser error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppBar(
        leftOptions: AppBarLeft(),
        centerOptions: AppBarCenter(label: '회원탈퇴'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 46),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Head2(value: '탈퇴하는 사유가 무엇인가요?'),
                const SizedBox(height: 8),
                Body2(
                    value: '포포의 서비스 개선에 많은 도움이 됩니다.', color: ThemeColor.gray5),
                Body2(
                  value: '최소 1개 이상 선택해 주세요.',
                  color: ThemeColor.gray5,
                  bold: true,
                ),
                const SizedBox(height: 40),
                WithdrawalReasonItem(
                  reason: '강아지 산책 기록을 하고 싶지 않아서',
                  isSelected: selectedReasons[0],
                  onSelected: (isSelected) {
                    _onSelectedReason(0, isSelected);
                  },
                ),
                WithdrawalReasonItem(
                  reason: '알림 기능을 선호하지 않아서',
                  isSelected: selectedReasons[1],
                  onSelected: (isSelected) {
                    _onSelectedReason(1, isSelected);
                  },
                ),
                WithdrawalReasonItem(
                  reason: '서비스 이용이 볼편해서',
                  isSelected: selectedReasons[2],
                  onSelected: (isSelected) {
                    _onSelectedReason(2, isSelected);
                  },
                ),
                WithdrawalReasonItem(
                  reason: '자주 사용하지 않아서',
                  isSelected: selectedReasons[3],
                  onSelected: (isSelected) {
                    _onSelectedReason(3, isSelected);
                  },
                ),
              ],
            ),
            Column(
              children: [
                Body4(
                  value: '포포와 헤어지게 된다니 너무 아쉬워요.',
                  color: ThemeColor.gray5,
                ),
                Body4(
                  value: '계정을 삭제하면 모든 활동 정보가 삭제됩니다.',
                  color: ThemeColor.gray5,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: DefaultTextButton(
                    text: '탈퇴하기',
                    onPressed: () {
                      showSharedDialog(
                        context,
                        AlertDialogType.WITHDRAWAL,
                        () {
                          _deleteUser();
                          Get.back();
                        },
                      );
                    },
                    disabled: !_isAnyReasonSelected(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class WithdrawalReasonItem extends StatelessWidget {
  final String reason;
  final ValueChanged<bool> onSelected;
  final bool isSelected;

  const WithdrawalReasonItem({
    super.key,
    required this.reason,
    required this.onSelected,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GestureDetector(
        onTap: () => onSelected(!isSelected),
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Body1(value: reason, color: ThemeColor.gray5),
            SvgPicture.asset(
              'assets/icons/direction.svg',
              width: 24,
              height: 24,
              colorFilter: isSelected
                  ? ColorFilter.mode(
                      ThemeColor.primary,
                      BlendMode.srcIn,
                    )
                  : ColorFilter.mode(
                      ThemeColor.gray3,
                      BlendMode.srcIn,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
