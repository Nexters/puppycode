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
import 'package:home_widget/home_widget.dart';
import 'package:kakao_flutter_sdk_auth/kakao_flutter_sdk_auth.dart';
import 'package:puppycode/shared/http.dart';
import 'package:puppycode/shared/states/user.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import './config.dart';
import 'firebase_options.dart';

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

  HomeWidget.setAppGroupId('group.pawpaw');

  Get.put(UserController());
  runApp(MyApp());
  _fetchTodayLog();
  _initDeepLinkListener();
}

Future _fetchTodayLog() async {
  try {
    final item = await HttpService.getOne('walk-logs/me/today');
    sendWidgetPhoto(item['photoUrl']).then(
      (_) => HomeWidget.updateWidget(
        name: 'pawpawWidget',
        iOSName: 'pawpawWidget',
      ),
    );
  } catch (error) {
    print('error: $error');
  }
}

Future sendWidgetPhoto(photoUrl) async {
  try {
    if (photoUrl == null) {
      HomeWidget.saveWidgetData('title', 'widget_ready');
    }
  } on PlatformException catch (err) {
    debugPrint('send data err: $err');
  }
}

Future<void> _initDeepLinkListener() async {
  late AppLinks appLinks;
  StreamSubscription<Uri>? linkSubscription;
  appLinks = AppLinks();

  linkSubscription = appLinks.uriLinkStream.listen((uri) {
    String id = uri.toString().split('/').last;
    Get.toNamed('/feed/$id');
  }, onError: (err) {});
}

Future<String?> initializeNotification() async {
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    await Future.delayed(const Duration(seconds: 1));

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
    } catch (e) {
      return '';
    }
  }
  return '';
}
