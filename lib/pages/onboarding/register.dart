import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/pages/onboarding/start.dart';
import 'package:puppycode/shared/function/sharedModalBottomSheet.dart';
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
  late String _location = '';

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
                onPressed: () => {Get.to(() => const StartPage())},
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
  final String value;
  final void Function(String value) onSelect;

  const LocationInputWithBottomSheet({
    super.key,
    required this.onSelect,
    required this.value,
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
                              child: Column(children: [
                                for (var location in _kLocationValues)
                                  LocationOption(
                                    location: location,
                                    isSelected: location == widget.value,
                                    onSelect: (selectedValue) => {
                                      setState(() {
                                        widget.onSelect(selectedValue);
                                        Get.back();
                                      })
                                    },
                                  )
                              ]),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )));
  }

  @override
  Widget build(BuildContext context) {
    onComplete() {
      setState(() {
        _isFocused = false;
      });
    }

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
                value: widget.value.isNotEmpty ? widget.value : '지역',
                color:
                    widget.value.isEmpty ? ThemeColor.gray4 : ThemeColor.gray6,
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
    required this.onSelect,
  });

  final String location;
  final bool isSelected;
  final void Function(String) onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {onSelect(location)},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 8, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Body1(value: location)),
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
