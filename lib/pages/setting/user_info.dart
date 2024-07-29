import 'package:flutter/material.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 정보'), // 왼쪽 정렬이 완벽하게 안됨
        centerTitle: false,
      ),
      body: const Column(
        children: [
          Text('앙꼬'),
        ],
      ),
    );
  }
}
