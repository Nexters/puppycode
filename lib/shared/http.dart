import 'dart:convert';
import 'dart:io';

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

  static Future<Map<String, dynamic>> patch(String endPoint,
      {Map<String, dynamic>? params, Map<String, dynamic>? body}) async {
    if (token.isEmpty) await _setToken();

    final url = Uri.http(baseUrl, '/api/$endPoint', params);
    http.Response res = await http.patch(
      url,
      headers: {
        if (params != null) 'Content-Type': 'application/json',
        'Authorization': token,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> result = json.decode(utf8.decode(res.bodyBytes));
      return result;
    } else {
      throw res.statusCode;
    }
  }

  static Future<Map<String, dynamic>> patchProfileImage(
      String endPoint, File imageFile) async {
    final url = Uri.http(baseUrl, '/api/$endPoint');

    var request = http.MultipartRequest('PATCH', url);

    // Authorization 헤더 추가
    request.headers['Authorization'] = token;
    request.headers['accept'] = 'application/json';

    // 파일 추가
    request.files.add(await http.MultipartFile.fromPath(
      'file', // 서버에서 기대하는 필드 이름
      imageFile.path,
    ));

    // 요청 보내기
    var response = await request.send();

    // 응답 처리
    if (response.statusCode == 200) {
      var responseData = await http.Response.fromStream(response);
      return json.decode(utf8.decode(responseData.bodyBytes));
    } else {
      throw Exception('Failed to update profile image: ${response.statusCode}');
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
