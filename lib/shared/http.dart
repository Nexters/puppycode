import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  const HttpService();
  static const String baseUrl = '175.106.99.165';

  static Future<List<dynamic>> get(String endPoint,
      {Map<String, dynamic>? params}) async {
    final url = Uri.http(baseUrl, '/api/$endPoint', params);
    http.Response res =
        await http.get(url, headers: {'Content-Type': 'application/json'});
    if (res.statusCode == 200) {
      Map<String, dynamic> body = json.decode(utf8.decode(res.bodyBytes));
      List<dynamic> items = body['items'];
      return items;
    } else {
      throw 'error'; // 에러 더 자세히 해야 함
    }
  }

  static Future<Map<String, dynamic>> getMap(String endPoint,
      {Map<String, dynamic>? params}) async {
    final url = Uri.http(baseUrl, '/api/$endPoint', params);
    http.Response res =
        await http.get(url, headers: {'Content-Type': 'application/json'});
    if (res.statusCode == 200) {
      Map<String, dynamic> body = json.decode(utf8.decode(res.bodyBytes));
      Map<String, dynamic> items = body['items'];
      return items;
    } else {
      throw 'error';
    }
  }
}
