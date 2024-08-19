import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  // initialize
  Config(config);
  KakaoSdk.init(nativeAppKey: config['KAKAO_SDK_KEY']);
  initializeNotification();

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  runApp(const MyApp());
}

void initializeNotification() async {
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? _fcmToken = await messaging.getToken();

  if (Platform.isIOS) {
    await messaging.requestPermission();
  }
  await messaging.setAutoInitEnabled(true);

  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}
