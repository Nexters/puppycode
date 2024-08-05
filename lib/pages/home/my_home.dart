import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/camera.dart';
import 'package:puppycode/shared/styles/button.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          const HomeTitle(),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 24, bottom: 20),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 20),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(228, 234, 238, 0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            height: 400,
            child: const HomeContent(),
          ),
          const CalendarButton(),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
            alignment: Alignment.topCenter,
            child: Text(
              '07:52',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -1.2,
                  height: 38 / 32,
                  color: Colors.black.withOpacity(0.6)),
            )),
        Positioned(
            width: MediaQuery.of(context).size.width - 16 * 2 - 20 * 2,
            height: 56,
            bottom: 0,
            child:
                DefaultTextButton(text: '오늘 산책도 무사히 완료!', onPressed: () => {}))
      ],
    );
  }
}

class CalendarButton extends StatelessWidget {
  const CalendarButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Container(
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 4),
            const Body1(value: '이번달 산책 캘린더'),
            const SizedBox(width: 4),
            const Body2(value: '4')
          ],
        ),
      ),
    );
  }
}

class HomeTitle extends StatelessWidget {
  const HomeTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Head1(value: '개떡이 발바닥 주의'),
        SizedBox(height: 9),
        Body2(value: '31℃')
      ],
    );
  }
}

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        height: 145,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            color: Colors.white,
          ),
          child: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // TODO: 버튼 구현
                children: [Text('< 7월 4주차 >'), Text('주')],
              ),
              HomeButtonRow(),
            ],
          ),
        ));
  }
}

class HomeButtonRow extends StatelessWidget {
  const HomeButtonRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        IconButton(
          onPressed: () => {},
          iconSize: 24,
          icon: const Icon(Icons.home),
        ),
        IconButton(
          onPressed: () => {
            showModalBottomSheet(
                context: context,
                builder: (context) => createFeedContainer(context))
          },
          icon: const Icon(Icons.create),
          iconSize: 24,
          style: ButtonStyle(
              fixedSize: WidgetStateProperty.all(const Size.square(60)),
              backgroundColor:
                  WidgetStateProperty.all(const Color(0xe5e5eaff))),
        ),
        IconButton(
          onPressed: () => {},
          iconSize: 24,
          icon: const Icon(Icons.calendar_today_rounded),
        )
      ],
    );
  }

  Widget createFeedContainer(BuildContext context) {
    var bottom = MediaQuery.of(context).viewInsets.bottom;

    return BottomSheet(
      onClosing: () => {},
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 30, bottom: bottom, left: 16, right: 16),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Container(
                child: const Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [BottomSheetTitle(), TimeOptionList()],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BottomSheetTitle extends StatelessWidget {
  const BottomSheetTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 88,
      child: Column(
        children: [
          Text(
            '오늘도 개떡이 오산완!',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          Text(
            '산책시간은 설정에서 변경할 수 있어요',
            style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4), fontSize: 16),
          )
        ],
      ),
    );
  }
}

class TimeOptionList extends StatelessWidget {
  const TimeOptionList({
    super.key,
  });

  setTime(String time) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TimeOptionButton(text: '20분 미만'),
        const TimeOptionButton(text: '20분~40분'),
        const TimeOptionButton(text: '40분~1시간'),
        const SizedBox(height: 12),
        SelectButton(),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget SelectButton() {
    return TextButton(
        onPressed: () => {Get.to(() => const CameraScreen())},
        style: TextButton.styleFrom(
          backgroundColor: Colors.black,
          fixedSize: const Size.fromHeight(56),
        ),
        child: const Text(
          '기록하러 가기',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ));
  }
}

class TimeOptionButton extends StatelessWidget {
  const TimeOptionButton({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: OutlinedButton(
        onPressed: () => {},
        style: OutlinedButton.styleFrom(
            fixedSize: const Size.fromHeight(48),
            side: const BorderSide(color: Colors.grey)),
        child: Text(text, style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}
