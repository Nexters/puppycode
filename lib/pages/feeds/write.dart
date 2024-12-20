import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';
import 'package:puppycode/apis/models/feed.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/episode.dart';
import 'package:puppycode/shared/http.dart';
import 'package:puppycode/shared/photo_item.dart';
import 'package:puppycode/shared/styles/button.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/states/user.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

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
  final ScrollController _scrollController = ScrollController();
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _episodeFocusNode = FocusNode();
  final GlobalKey episodeKey = GlobalKey();
  final userController = Get.find<UserController>();
  String photoPath = '';
  String from = '';
  String content = '';
  Feed? feed;
  bool isFetching = true;
  double? episodePositon;
  bool isEditing = false;

  bool isLoading = false;
  bool isError = false;

  final List<String> timeOptions = ['20분 내외', '20분~40분', '40분~1시간'];
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future sendWidgetPhoto() async {
    try {
      return Future.wait([
        HomeWidget.renderFlutterWidget(
          ClipRRect(
            borderRadius: BorderRadius.circular(20.25),
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 160,
                height: 160,
                child: Image.file(
                  File(photoPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          logicalSize: const Size(160, 160),
          key: 'title',
        ),
      ]);
    } on PlatformException catch (err) {}
  }

  Future updateHomeWidget() async {
    try {
      return Future.wait([
        HomeWidget.updateWidget(
          name: 'pawpawWidget',
          iOSName: 'pawpawWidget',
        )
      ]);
    } on PlatformException catch (exception) {}
  }

  Future<void> _sendAndUpdate() async {
    await sendWidgetPhoto();
    await updateHomeWidget();
  }

  @override
  void initState() {
    super.initState();

    if (Get.arguments['photoPath'] != null) {
      photoPath = Get.arguments['photoPath'];
      from = Get.arguments['from'];
      isFetching = false;
    } else if (Get.arguments['id'] != null) {
      _fetchFeedDetails(Get.arguments['id']);
      isEditing = true;
      if (Get.arguments['from'] == 'episode') {
        Future.delayed(const Duration(milliseconds: 100), () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.hasClients) {
              _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
            }
            FocusScope.of(context).requestFocus(_episodeFocusNode);
          });
        });
      } else {
        Future.delayed(const Duration(milliseconds: 100), () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.hasClients) {
              _scrollController.animateTo(
                  _scrollController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
            }
            FocusScope.of(context).requestFocus(_titleFocusNode);
          });
        });
      }
    }

    var options = [];
    for (int i = 0; i < _kOptionCount; i++) {
      if (i == 0) {
        options.add('$_kInitialTime분 미만');
      } else {
        options.add('$_kInitialTime분~${_kInitialTime + _kInitialGap}');
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchFeedDetails(id) async {
    try {
      final item = await HttpService.getOne('walk-logs/$id');
      setState(() {
        feed = Feed(item);
        photoPath = feed!.photoUrl;
        selectedTime = feed!.walkTime;
        titleController.text = feed!.title;
        episodeController.text = feed!.episode;
        isFetching = false;
      });
    } catch (error) {}
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
      if (result['success'] == true) {
        await userController.refreshData();
        _sendAndUpdate();
        Get.offAndToNamed('/create/success',
            arguments: {'from': from, 'feedId': result['data']['id'] ?? ''});
      } else {
        isError = true;
      }
    } catch (err) {
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  Future<void> _patchFeed(id) async {
    try {
      setState(() {
        isLoading = true;
      });
      var result = await HttpService.patchMultipartForm(
        'walk-logs/$id',
        body: {
          'title': titleController.text,
          'content': episodeController.text,
          'walkTime': selectedTime,
        },
        //imagePath: photoPath
      );
      setState(() {
        isLoading = false;
      });
      if (result['success'] == true) {
        await userController.refreshData();
        Get.offAndToNamed('/feed/${feed!.id}',
            arguments: {'from': from, 'feedId': result['data']['id'] ?? ''});
      } else {
        isError = true;
      }
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: SharedAppBar(
            leftOptions: AppBarLeft(iconType: LeftIconType.CLOSE),
            centerOptions: AppBarCenter(label: '산책 기록하기'),
          ),
          body: isFetching
              ? Center(
                  child: CircularProgressIndicator(color: ThemeColor.primary))
              : SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                              children: [
                                PhotoItem(
                                  photoPath: photoPath,
                                  titleController: titleController,
                                  focusNode: _titleFocusNode,
                                  onChange: onTitleChange,
                                  name: userController.user.value!.nickname,
                                  isEditing: feed != null ? true : false,
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                Episode(
                                  key: episodeKey,
                                  isInput: true,
                                  controller: episodeController,
                                  content: content,
                                  focusNode: _episodeFocusNode,
                                ),
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
                onPressed: () {
                  if (titleController.text.isEmpty || isLoading) return;
                  if (feed == null) {
                    analytics.logEvent(name: 'completeRecord');
                    _createFeed();
                  } else {
                    analytics.logEvent(name: 'AddEpisode-complete');
                    _patchFeed(feed!.id);
                  }
                },
                text: isLoading
                    ? '기록 저장 중...'
                    : isEditing
                        ? '완료하기'
                        : '기록 남기기',
                disabled: titleController.text.isEmpty || isLoading,
              ),
            ),
          )),
    );
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
