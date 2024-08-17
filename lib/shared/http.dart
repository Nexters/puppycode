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

  static Future<Map<String, dynamic>> post(
      String endPoint, Map<String, dynamic> body) async {
    final url = Uri.http(baseUrl, '/api/$endPoint');
    http.Response res = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: json.encode(body));
    print(body);
    print(json.encode(body));
    if (res.statusCode == 200) {
      Map<String, dynamic> result = json.decode(utf8.decode(res.bodyBytes));
      return result;
    } else {
      throw 'failed';
    }
  }

  static Future<Map<String, dynamic>> getOne(String endPoint,
      {Map<String, dynamic>? params}) async {
    final url = Uri.http(baseUrl, '/api/$endPoint', params);
    http.Response res =
        await http.get(url, headers: {'Content-Type': 'application/json'});
    if (res.statusCode == 200) {
      Map<String, dynamic> body = json.decode(utf8.decode(res.bodyBytes));
      return body; // 단일 객체
    } else {
      throw 'error';
    }
  }
}
