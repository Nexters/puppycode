import 'package:flutter/material.dart';
import 'package:puppycode/pages/setting.dart';
import 'package:get/get.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Home'),
      ),
      body: Center(
          child: TextButton(
        child: const Text('마이홈입니당'),
        onPressed: () {
          Get.to(() => const SettingPage());
        },
      )),
    );
  }
}
