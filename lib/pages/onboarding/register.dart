// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/function/sharedModalBottomSheet.dart';
import 'package:puppycode/shared/http.dart';
import 'package:puppycode/shared/input.dart';
import 'package:puppycode/shared/styles/button.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:puppycode/shared/user.dart';

enum LOCATION {
  SEOUL,
  BUSAN,
  DAEGU,
  INCHEON,
  GWANGJU,
  DAEJEON,
  ULSAN,
  SEJONG,
  GYEONGGI,
  GANGWON,
  CHUNGBUK,
  CHUNGNAM,
  JEONBUK,
  JEONNAME,
  GYEONGBUK,
  GYEONGNAM,
  JEJU
}

extension LocationExtension on LOCATION {
  String get name => toString().split('.').last;
}

extension StringExtension on String {
  LOCATION? toLocation() {
    return LOCATION.values.firstWhere((e) => e.name == this);
  }
}

Map<LOCATION, String> locationNames = {
  LOCATION.SEOUL: "서울",
  LOCATION.BUSAN: "부산",
  LOCATION.DAEGU: "대구",
  LOCATION.INCHEON: "인천",
  LOCATION.GWANGJU: "광주",
  LOCATION.DAEJEON: "대전",
  LOCATION.ULSAN: "울산",
  LOCATION.SEJONG: "세종",
  LOCATION.GYEONGGI: "경기",
  LOCATION.GANGWON: "강원",
  LOCATION.CHUNGBUK: "충북",
  LOCATION.CHUNGNAM: "충남",
  LOCATION.JEONBUK: "전북",
  LOCATION.JEONNAME: "전남",
  LOCATION.GYEONGBUK: "경북",
  LOCATION.GYEONGNAM: "경남",
  LOCATION.JEJU: "제주"
};

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _nameController = TextEditingController();
  LOCATION? _location;
  late String authToken;
  late String provider;
  late String? profileUrl;
  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      authToken = Get.arguments['oAauthToken'];
      profileUrl = Get.arguments['profileUrl'];
      provider = Get.arguments['provider'];
    }
  }

  void _signup() async {
    if (authToken.isEmpty) return;
    try {
      Map<String, dynamic> result =
          await HttpService.post('auth/signup', body: {
        'oauthIdentifier': authToken,
        'nickname': _nameController.text,
        'profileUrl': profileUrl ?? '',
        'city': _location?.name ?? '',
        'provider': provider
      });

      String? token = result['token'];
      if (token == null) {
        throw 'empty token';
      }

      const storage = FlutterSecureStorage();
      await storage.write(key: 'authToken', value: token);
      await userController.refreshData();
      Get.toNamed('/start', arguments: {'name': _nameController.text});
    } catch (err) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SharedAppBar(
        leftOptions: AppBarLeft(),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GuideText(),
            TextInput(
              onChanged: (value) => {setState(() {})},
              controller: _nameController,
              hintText: '강아지 이름',
              maxLength: 10,
            ),
            const SizedBox(height: 16),
            LocationInputWithBottomSheet(
              value: _location,
              onSelect: (location) => {
                setState(() {
                  _location = location;
                })
              },
            ),
            // 지역 INPUT
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 12),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                  child: DefaultTextButton(
                text: '등록하기',
                onPressed: () => {_signup()},
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class GuideText extends StatelessWidget {
  const GuideText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 46),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Head2(value: '우리 집 강아지의 이름과\n사는 곳을 설정해 볼까요?'),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Body2(value: '키우는 강아지가 없어도 괜찮아요.', color: Color(0xFF50555C)),
          )
        ],
      ),
    );
  }
}

class LocationInputWithBottomSheet extends StatefulWidget {
  final LOCATION? value;
  final void Function(LOCATION value) onSelect;

  const LocationInputWithBottomSheet({
    super.key,
    required this.onSelect,
    this.value,
  });

  @override
  State<LocationInputWithBottomSheet> createState() =>
      _LocationInputWithBottomSheetState();
}

class _LocationInputWithBottomSheetState
    extends State<LocationInputWithBottomSheet> {
  bool _isFocused = false;

  Widget _createLocationSelectContainer(BuildContext context) {
    return BottomSheet(
        onClosing: () => {},
        builder: (context) => StatefulBuilder(
            builder: (BuildContext context, setState) => Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Head3(value: '어디에 사시나요?'),
                      const SizedBox(height: 3),
                      const Body3(value: '지역을 설정하면 날씨 정보를 제공해 드려요.'),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SizedBox(
                              child: Column(
                                  children: locationNames.entries
                                      .map((entry) => LocationOption(
                                            value: entry.key,
                                            label: entry.value,
                                            isSelected:
                                                entry.key == widget.value,
                                            onSelect: (selectedValue) => {
                                              setState(() {
                                                widget.onSelect(selectedValue);
                                                Get.back();
                                              })
                                            },
                                          ))
                                      .toList()),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )));
  }

  void onComplete() {
    setState(() {
      _isFocused = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              setState(() {
                _isFocused = true;
              }),
              sharedModalBottomSheet(
                  context, _createLocationSelectContainer(context), onComplete)
            },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: _isFocused ? ThemeColor.primary : ThemeColor.gray2)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Body1(
                value:
                    widget.value != null ? locationNames[widget.value]! : '지역',
                color:
                    widget.value == null ? ThemeColor.gray4 : ThemeColor.gray6,
              ),
              SvgPicture.asset('assets/icons/chevron_bottom.svg',
                  colorFilter:
                      ColorFilter.mode(ThemeColor.gray3, BlendMode.srcIn))
            ],
          ),
        ));
  }
}

class LocationOption extends StatelessWidget {
  const LocationOption({
    super.key,
    required this.value,
    required this.label,
    required this.isSelected,
    required this.onSelect,
  });

  final LOCATION value;
  final String label;
  final bool isSelected;
  final void Function(LOCATION) onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {onSelect(value)},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 8, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Body1(value: label)),
            if (isSelected)
              SvgPicture.asset(
                'assets/icons/check.svg',
                colorFilter:
                    ColorFilter.mode(ThemeColor.primary, BlendMode.srcIn),
              )
          ],
        ),
      ),
    );
  }
}
