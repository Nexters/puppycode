import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puppycode/pages/route.dart';
import 'package:puppycode/shared/styles/color.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
          scaffoldBackgroundColor: ThemeColor.white,
          appBarTheme: AppBarTheme(backgroundColor: ThemeColor.white),
          bottomNavigationBarTheme:
              BottomNavigationBarThemeData(backgroundColor: ThemeColor.white),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: ThemeColor.primary),
        bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: ThemeColor.white),
          inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          )
      ),
      initialRoute: '/onboarding/info',
      getPages: AppRoutes.routes,
    );
  }
}
