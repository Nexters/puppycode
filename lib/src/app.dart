import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puppycode/pages/route.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: AppRoutes.routes,
    );
  }
}
