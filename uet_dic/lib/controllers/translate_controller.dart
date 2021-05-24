import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uet_dic/share/app_api.dart' as api;
import 'package:uet_dic/share/app_loading.dart';

class TranslateController {
  String _message;
  int _statusCode;

  /// translate text
  /// sl: source language
  /// tl: target language
  Future<String> translateText(String text, String sl, String tl) async {
    String translatedText = text;
    try {
      text = text.trim();
      print('Translating ...');

      final response = await http.get(
        Uri.parse('${api.googleTranslateApi}&q=$text&source=$sl&target=$tl&format=text'),
      ).timeout(const Duration(seconds: 10));

      final responseBody = json.decode(response.body);
      this._statusCode = responseBody['error'] == null ? 200 : 400;
      print(responseBody['error']);

      if (this._statusCode != 200) this._message = 'Translate text fail';
      else {
        this._message = 'Translate text success';
         translatedText = responseBody['data']['translations'][0]['translatedText'];
      }
    } catch (err) {
      this._message = 'Check your internet or try later';
      print('Translate text error: $err');
      this._statusCode = 400;
    }
    showToast(this._message, this._statusCode);
    return translatedText;
  }
}