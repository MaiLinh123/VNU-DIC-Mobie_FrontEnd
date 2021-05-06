import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uet_dic/share/app_api.dart' as api;

void main() async {
  String token = '';
  var url = Uri.parse(api.userApi);
  var response = await http.put(
    url,
    headers: {
      'x-access-token' : token,
    },
    body: {
      'old_password': '123456',
      'password': '1234567',
      'repeat_password': '1234567',
    },
  ).timeout(const Duration(seconds: 5));

  final _responseBody = json.decode(response.body);
  final _statusCode = response.statusCode;
  print(_responseBody['message']);
  print(_statusCode);
}
