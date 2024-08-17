import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:puppycode/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HttpService {
  static const String baseUrl = '175.106.99.165';
  static String token = '';
  static const storage = FlutterSecureStorage();

  static _setToken() async {
    if (Config.isLocal) token = 'Bearer ${Config.TOKEN}';
    var authToken = (await storage.read(key: 'authToken'))!;
    token = 'Bearer $authToken';
  }

  static _handleError(http.Response res) async {
    if (res.statusCode == 401) {
      await storage.delete(key: 'authToken');
      Get.offNamed('/login');
    }
    var message = json.decode(utf8.decode(res.bodyBytes))['message'];
    print(message);
    throw res.statusCode;
  }

  static Future<List<dynamic>> get(String endPoint,
      {Map<String, dynamic>? params}) async {
    if (token.isEmpty) await _setToken();

    final url = Uri.http(baseUrl, '/api/$endPoint', params);
    http.Response res = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    });
    if (res.statusCode == 200) {
      Map<String, dynamic> body = json.decode(utf8.decode(res.bodyBytes));
      List<dynamic> items = body['items'];
      return items;
    } else {
      _handleError(res);
      throw 'err';
    }
  }

  static Future<Map<String, dynamic>> postMultipartForm(String endPoint,
      {required Map<String, dynamic> body,
      required String imagePath,
      Map<String, dynamic>? headers}) async {
    if (token.isEmpty) await _setToken();

    try {
      final url = Uri.http(baseUrl, '/api/$endPoint');
      var request = http.MultipartRequest('POST', url);
      final httpImage = await http.MultipartFile.fromPath('photo', imagePath);
      var jsonBody = http.MultipartFile.fromBytes(
        'request',
        utf8.encode(jsonEncode(body)),
      );
      request.files.add(jsonBody);
      request.files.add(httpImage);
      request.headers.addAll({'Authorization': token});
      await request.send();
      return {'success': true};
    } catch (err) {
      return {'success': false};
    }
  }

  static Future<Map<String, dynamic>> post(String endPoint,
      {required Map<String, dynamic> body,
      Map<String, dynamic>? headers}) async {
    if (token.isEmpty) await _setToken();

    final url = Uri.http(baseUrl, '/api/$endPoint');
    http.Response res = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: json.encode(body));
    if (res.statusCode == 200) {
      Map<String, dynamic> result = json.decode(utf8.decode(res.bodyBytes));
      return result;
    } else {
      throw res.statusCode;
    }
  }

  static Future<Map<String, dynamic>> getOne(String endPoint,
      {Map<String, dynamic>? params}) async {
    if (token.isEmpty) await _setToken();
    final url = Uri.http(baseUrl, '/api/$endPoint', params);
    http.Response res = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    });
    if (res.statusCode == 200) {
      Map<String, dynamic> body = json.decode(utf8.decode(res.bodyBytes));
      return body; // 단일 객체
    } else {
      _handleError(res);
      throw 'err';
    }
  }
}
