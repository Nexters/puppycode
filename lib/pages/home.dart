import 'package:flutter/material.dart';
import 'package:puppycode/pages/setting/setting.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
          child: TextButton(
        child: const Text('go to setting'),
        onPressed: () {
          Get.to(() => const SettingPage());
        },
      )),
    );
  }
}
