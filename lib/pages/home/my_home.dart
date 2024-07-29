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
          onPressed: () => {},
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
}
