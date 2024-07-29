import 'package:flutter/material.dart';
//import 'package:get/get.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Home'),
      ),
      bottomNavigationBar: const HomeNavigationBar(),
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
                builder: (context) => createPostContainer(context))
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

  Widget createPostContainer(BuildContext context) {
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
        onPressed: () => {},
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
