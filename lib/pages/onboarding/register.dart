import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/pages/onboarding/start.dart';
import 'package:puppycode/shared/input.dart';
import 'package:puppycode/shared/styles/button.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
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
            const LocationInputWithBottomSheet(),
            // 지역 INPUT
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
                child: DefaultTextButton(
              text: '등록하기',
              onPressed: () => {Get.to(() => const StartPage())},
            )),
          ],
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
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 64),
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

List<String> _kLocationValues = [
  '서울',
  '부산',
  '대구',
  '인천',
  '광주',
  '대전',
  '울산',
  '경기'
];

class LocationInputWithBottomSheet extends StatefulWidget {
  final String? value;

  const LocationInputWithBottomSheet({
    super.key,
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
        builder: (context) => Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Head3(value: '어디에 사시나요?'),
                    SizedBox(height: 3),
                    Body3(value: '지역을 설정하면 날씨 정보를 제공해 드려요.'),
                    SizedBox(height: 12),
                    SingleChildScrollView(
                      child: Column(children: [
                        for (var location in _kLocationValues)
                          LocationOption(
                            location: location,
                            isSelected: location == '서울',
                          )
                      ]),
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              setState(() {
                _isFocused = true;
              }),
              showModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      _createLocationSelectContainer(context)).whenComplete(() {
                setState(() {
                  _isFocused = false;
                });
              })
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
                value: widget.value ?? '지역',
                color:
                    widget.value == null ? ThemeColor.gray4 : ThemeColor.gray6,
              ),
              RotatedBox(
                quarterTurns: 3,
                child: SvgPicture.asset('assets/icons/chevron_left.svg',
                    colorFilter:
                        ColorFilter.mode(ThemeColor.gray3, BlendMode.srcIn)),
              )
            ],
          ),
        ));
  }
}

class LocationOption extends StatelessWidget {
  const LocationOption({
    super.key,
    required this.location,
    required this.isSelected,
  });

  final String location;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 8, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Body1(value: location),
          if (isSelected)
            SvgPicture.asset(
              'assets/icons/check.svg',
              colorFilter:
                  ColorFilter.mode(ThemeColor.primary, BlendMode.srcIn),
            )
        ],
      ),
    );
  }
}
