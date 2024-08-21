import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/episode.dart';
import 'package:puppycode/shared/http.dart';
import 'package:puppycode/shared/photo_item.dart';
import 'package:puppycode/shared/styles/button.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/user.dart';

class FeedWritePage extends StatefulWidget {
  const FeedWritePage({super.key});

  @override
  State<FeedWritePage> createState() => _FeedWritePageState();
}

const _kInitialTime = 20;
const _kInitialGap = 20;
const _kOptionCount = 3;

class _FeedWritePageState extends State<FeedWritePage> {
  String? selectedTime;
  List<String> options = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController episodeController = TextEditingController();
  late String photoPath;
  late String from;

  bool isLoading = false;
  bool isError = false;

  final List<String> timeOptions = ['20분 내외', '20분~40분', '40분~1시간'];

  @override
  void initState() {
    super.initState();
    photoPath = Get.arguments['photoPath'];
    from = Get.arguments['from'];

    var options = [];
    for (int i = 0; i < _kOptionCount; i++) {
      if (i == 0) {
        options.add('$_kInitialTime분 미만');
      } else {
        options.add('$_kInitialTime분~${_kInitialTime + _kInitialGap}');
      }
    }
  }

  List<Widget> _optionButtons() {
    List<Widget> widgets = [];
    for (int i = 0; i < 3; i++) {
      String value = timeOptions[i];

      widgets.add(OptionButton(
          label: value,
          isSelected: selectedTime == value,
          onPressed: () => {_onTimeButtonPressd(value)}));

      if (i != 2) {
        widgets.add(const SizedBox(
          width: 12,
        ));
      }
    }

    return widgets;
  }

  void _onTimeButtonPressd(String value) {
    setState(() {
      selectedTime = value;
    });
  }

  void onTitleChange() {
    setState(() {});
  }

  void _createFeed() async {
    try {
      setState(() {
        isLoading = true;
      });
      var result = await HttpService.postMultipartForm('walk-logs',
          body: {
            'title': titleController.text,
            'content': episodeController.text,
            'walkTime': selectedTime,
          },
          imagePath: photoPath);
      setState(() {
        isLoading = false;
      });
      isLoading = false;
      if (result['success'] == true) {
        var userController = Get.find<UserController>();
        await userController.refreshData();
        Get.offAndToNamed('/create/success',
            arguments: {from: from, 'feedId': result['data']['id'] ?? ''});
      } else {
        isError = true;
      }
    } catch (err) {
      isLoading = false;
      isError = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading)
      return Container(
        child: Body2(
          value: '로딩중',
        ),
      );
    return Scaffold(
        appBar: SharedAppBar(
          leftOptions: AppBarLeft(iconType: LeftIconType.CLOSE),
          centerOptions: AppBarCenter(label: '산책 기록하기'),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        PhotoItem(
                          photoPath: photoPath,
                          titleController: titleController,
                          onChange: onTitleChange,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Body2(value: '산책한 시간', bold: true),
                            Container(
                                margin: const EdgeInsets.only(top: 8),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: _optionButtons(),
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(height: 20),
                        Episode(isInput: true, controller: episodeController),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 12),
            child: DefaultElevatedButton(
              onPressed: () => {_createFeed()},
              text: '기록 남기기',
              disabled: titleController.text.isEmpty,
            ),
          ),
        ));
  }
}

class OptionButton extends StatelessWidget {
  const OptionButton(
      {super.key,
      required this.isSelected,
      required this.label,
      required this.onPressed});

  final VoidCallback onPressed;
  final String label;
  final bool isSelected;
  static const _borderColor = Color(0xFFE4EAEE);
  static const _textColor = Color(0xFF72757A);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
          side:
              BorderSide(color: isSelected ? ThemeColor.primary : _borderColor),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)))),
      onPressed: onPressed,
      child: Body4(
        value: label,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        color: isSelected ? null : _textColor,
      ),
    );
  }
}
