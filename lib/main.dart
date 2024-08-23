import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_auth.dart';
import 'package:puppycode/shared/states/user.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import './config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final String configString = await rootBundle.loadString('assets/config.json');
  Map<String, dynamic> config = json.decode(configString);

  // initialize
  var fcmToken = await initializeNotification();
  Config(config, fcmToken);
  KakaoSdk.init(nativeAppKey: config['KAKAO_SDK_KEY']);

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  Get.put(UserController());
  runApp(const MyApp());
  _initDeepLinkListener();
}

Future<void> _initDeepLinkListener() async {
  late AppLinks appLinks;
  StreamSubscription<Uri>? linkSubscription;
  appLinks = AppLinks();

  linkSubscription = appLinks.uriLinkStream.listen((uri) {
    debugPrint('onAppLink: $uri');
    String id = uri.toString().split('/').last;
    Get.toNamed('/feed/$id');
  }, onError: (err) {
    print('딥링크 에러 $err');
  });
}

Future<String?> initializeNotification() async {
  try {
    await Firebase.initializeApp();

    await Future.delayed(const Duration(seconds: 3));

    if (Config.env != 'LOCAL') {
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? fcmToken = await messaging.getToken();

    if (Platform.isIOS) {
      await messaging.requestPermission();
    }

    await messaging.setAutoInitEnabled(true);

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    return fcmToken;
  } catch (err, errStack) {
    try {
      FirebaseCrashlytics.instance.recordError(err, errStack, fatal: true);
    } catch (e) {}
  }
  return '';
}
