import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uet_dic/share/app_api.dart' as api;


void main() async {
  // var url = Uri.parse(api.signInApi);
  var token =  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwODUxOTE1ODJhOWE0MDAxZWRiM2UyNiIsImlhdCI6MTYxOTc4OTg5MCwiZXhwIjoxNjE5ODc2MjkwfQ.5Vw6cVWC_B1DZ1FKOwZerUFdIzv6NSKnq9EJNby22V4';

  // var token = await http.post(url, body: {
  //   'email': 'long1@gmail.com',
  //   'password': '123456'
  // });

  var url = Uri.parse(api.saveWordApi);

  var response = await http.put(
    url,
    headers: {'x-access-token': token},
    body: {"wordId": '60837ba4df926e85d065fa70'},
  );

  final _responseBody = response.body;
  final _statusCode = response.statusCode;
  print(_responseBody);
  print(_statusCode);
}