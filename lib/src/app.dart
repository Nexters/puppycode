import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puppycode/pages/route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white)
      ),
      initialRoute: '/',
      getPages: AppRoutes.routes,
    );
  }
}
