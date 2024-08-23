import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:puppycode/apis/models/user.dart';
import 'package:puppycode/pages/setting/setting.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/http.dart';
import 'package:puppycode/shared/nav_bar.dart';
import 'package:puppycode/shared/image.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';
import 'package:puppycode/shared/states/user.dart';
import 'package:share_plus/share_plus.dart';

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
  final userController = Get.find<UserController>();

  XFile? _image;
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
      });
    }
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
      if (_isEditing) {
        FocusScope.of(context).requestFocus(_focusNode); // TextField에 포커스 요청
      } else {
        _editProfile();
      }
    });
  }

  //프로필 변경
  void _editProfile() async {
    try {
      if (_editingController.text.isEmpty) {
        _editingController.text = '포포';
      }
      await HttpService.patch('users/nickname',
          params: {'nickname': _editingController.text},
          onPatch: () => userController.refreshData());

      if (_image != null) {
        await HttpService.patchProfileImage(
            'users/profile-image', File(_image!.path),
            onPatch: () => userController.refreshData());
      }
    } catch (err) {
      print('edit Error: $err');
    }
  }

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
      User user = userController.user.value as User;

      setState(() {
        code = user.code;
        _editingController.text = user.nickname;
        profileImageUrl = user.profileImageUrl;
      });
    } catch (error) {
      print('fetchUser Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            GestureDetector(
              onTap: () {
                if (_isEditing) getImage(ImageSource.gallery);
              },
              child: Stack(
                children: [
                  ClipOval(
                    child: _image != null
                        ? SizedBox(
                            height: 128,
                            width: 128,
                            child: Image.file(
                              fit: BoxFit.cover,
                              File(_image!.path),
                            ),
                          )
                        : UserNetworkImage(
                            url: profileImageUrl,
                            fit: BoxFit.cover,
                            height: 128,
                            width: 128),
                  ),
                  if (_isEditing)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 32,
                        height: 32,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: ThemeColor.white,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: ThemeColor.black.withOpacity(0.13),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/write.svg',
                          colorFilter: ColorFilter.mode(
                            ThemeColor.primary,
                            BlendMode.srcIn,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                ],
              ),
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
                        HeadTextStyle.getH3Style(color: ThemeColor.gray3),
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
              onPressed: () {
                Share.share(code, subject: 'Pawpaw');
              },
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all<Color>(ThemeColor.gray2),
                padding: WidgetStateProperty.all<EdgeInsets>(
                  const EdgeInsets.fromLTRB(16, 8, 14, 8),
                ),
              ),
              child: SizedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Body4(
                      value: '@$code',
                      fontWeight: FontWeight.w600,
                      color: ThemeColor.gray5,
                    ),
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
            ),
            const SizedBox(height: 32),
            if (!_isEditing) ...[
              SingleChildScrollView(
                child: SettingList(lists: [
                  SettingListItem(
                    title: '산책일지',
                    onTab: () =>
                        Get.toNamed('/', arguments: {'tab': NavTab.my}),
                  ),
                  const SettingListItem(
                    destination: '/calendar',
                    title: '산책 캘린더',
                  )
                ], title: ''),
              ),
              Expanded(child: Container()),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Body4(
                      value: '로그아웃',
                      color: ThemeColor.gray4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    child: Body4(
                      value: '회원탈퇴',
                      color: ThemeColor.gray4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 57),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
