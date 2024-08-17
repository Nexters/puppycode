import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/pages/setting/setting.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/http.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';
import 'package:share/share.dart';

class User {
  User(dynamic userItem) {
    id = userItem['id'];
    nickname = userItem['nickname'];
    profileImageUrl = userItem['profileImageUrl'];
    code = userItem['code'];
    createdAt = userItem['createdAt'];
  }

  late int id;
  late String profileImageUrl;
  late String nickname;
  late String code;
  late String createdAt;
}

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  late String code = '';
  late String profileImageUrl = '';
  bool _isEditing = false;
  bool _isValidName = false;
  late final TextEditingController _editingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
      if (_isEditing) {
        FocusScope.of(context).requestFocus(_focusNode); // TextField에 포커스 요청
      }
    });
  }

  // 프로필 변경
  // void _editProfile() {

  // }

  bool validateName(name) {
    setState(() {
      _isValidName = name.length > 1;
    });

    return _isValidName;
  }

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  @override
  void dispose() {
    _editingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _fetchUser() async {
    try {
      final userData = await HttpService.getOne('users');

      User user = User(userData);

      setState(() {
        code = user.code;
        _editingController.text = user.nickname;
        profileImageUrl = user.profileImageUrl;
      });
    } catch (error) {
      print(error);
    }
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
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: profileImageUrl.isNotEmpty
                  ? Image.network(profileImageUrl, height: 128, width: 128)
                  : Image.asset('assets/images/profile.png',
                      height: 128, width: 128),
            ),
            Container(
              height: 48,
              padding: const EdgeInsets.only(top: 12),
              child: Center(
                child: TextField(
                  controller: _editingController,
                  focusNode: _focusNode,
                  readOnly: !_isEditing,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: '포포',
                    hintStyle:
                        HeadTextStyle.getH3Style(color: ThemeColor.gray4),
                  ),
                  style: HeadTextStyle.getH3Style(),
                  textAlign: TextAlign.center,
                  cursorColor: ThemeColor.primary,
                  cursorHeight: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextButton(
              onPressed: () => {Share.share(code)},
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all<Color>(ThemeColor.gray2),
                padding: WidgetStateProperty.all<EdgeInsets>(
                    const EdgeInsets.only(right: 14, left: 16)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Body4(value: '@$code'),
                  const SizedBox(width: 4),
                  SvgPicture.asset(
                    'assets/icons/link.svg',
                    height: 20,
                    width: 20,
                    colorFilter:
                        ColorFilter.mode(ThemeColor.gray4, BlendMode.srcIn),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            if (!_isEditing)
              const SettingList(lists: [
                SettingListItem(
                  title: '산책일지',
                  widget: Icon(
                    color: Color.fromRGBO(128, 128, 128, 0.55),
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ),
                SettingListItem(
                  title: '산책 캘린더',
                  widget: Icon(
                    color: Color.fromRGBO(128, 128, 128, 0.55),
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                )
              ], title: ''),
          ],
        ),
      ),
    );
  }
}
