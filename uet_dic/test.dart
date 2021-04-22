import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {

  var accessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwN2MzYTcwZmMxYWMxMDAxZWJiMmUxYSIsImlhdCI6MTYxODc1NDU2NywiZXhwIjoxNjE4ODQwOTY3fQ.S2SgOLt5QJMX59sab1hSz0fVon9EIuSDwBMCLQ8YykA';
  var url = Uri.parse('http://localhost:3333/api/users/current');
  //var response = await http.post(url, body: {'username': 'long test' , 'password': '123456'});
  var response = await http.get(url, body: {}, Http);
  final Map parsed = json.decode(response.body);
  print('$parsed, ${response.statusCode}');
}