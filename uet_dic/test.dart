import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uet_dic/share/app_api.dart' as api;


void main() async {
  String text = "Hello world";
  String source = "en";
  String target = "vi";
  String key = "AIzaSyBxqV2ta8EmLMWhc2xWGfhq1EaZAHGBGig";
  print(Uri.parse('&q=$text&source=$source&target=$target&format=text'));
  final response = await http.get(
    Uri.parse('https://translation.googleapis.com/language/translate/v2?key=$key&q=$text&source=$source&target=$target&format=text'),
  ).timeout(const Duration(seconds: 10));

  final responseBody = json.decode(response.body);
  print(responseBody);
}
