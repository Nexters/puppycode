import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_auth.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import './config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final String configString = await rootBundle.loadString('assets/config.json');
  Map<String, dynamic> config = json.decode(configString);

  Config(config);
  KakaoSdk.init(nativeAppKey: config['KAKAO_SDK_KEY']);

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  runApp(const MyApp());
}
