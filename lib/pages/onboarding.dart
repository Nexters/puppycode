import 'package:flutter/material.dart';
import 'package:puppycode/pages/setting.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

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
          Get.to(() => SettingPage());
        },
      )),
    );
  }
}
