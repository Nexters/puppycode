import 'package:flutter/material.dart';
import 'package:puppycode/pages/setting/setting.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:share/share.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  String code = 'S89DF1';
  String userName = '개떡이';
  bool _isEditing = false;
  bool _isValidName = false;

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void validateName() {
    setState(() {
      _isValidName = userName.length > 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppBar(
          leftOptions: AppBarLeft(iconType: LeftIconType.BACK),
          centerOptions: AppBarCenter(label: '내 프로필'),
          rightOptions: !_isEditing
              ? AppBarRight(
                  label: '편집',
                  labelColor: ThemeColor.gray4,
                  onLabelClick: _toggleEditing,
                )
              : AppBarRight(
                  label: '저장',
                  labelColor: ThemeColor.primary,
                  onLabelClick: _toggleEditing,
                )),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Center(
              child: Column(
                children: [
                  Container(
                    height: 128,
                    width: 128,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    initialValue: userName,
                    readOnly: !_isEditing,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: _isEditing ? '이름 입력해주쇼' : ''),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      setState(() {
                        userName = value;
                        validateName();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextButton(
                    onPressed: () => {Share.share(code)},
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.grey)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '@$code ',
                          style: const TextStyle(color: Colors.black),
                        ),
                        const Icon(
                          Icons.link,
                          color: Color.fromARGB(255, 221, 221, 221),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  const SettingList(lists: [
                    SettingListItem(
                        title: '산책일지',
                        widget: Icon(
                          color: Color.fromRGBO(128, 128, 128, 0.55),
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                        destination: ''),
                    SettingListItem(
                        title: '산책 캘린더',
                        widget: Icon(
                          color: Color.fromRGBO(128, 128, 128, 0.55),
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                        destination: '')
                  ], title: ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
