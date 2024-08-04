import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puppycode/pages/route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.white),
          inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          )
      ),
      initialRoute: '/home',
      getPages: AppRoutes.routes,
    );
  }
}
