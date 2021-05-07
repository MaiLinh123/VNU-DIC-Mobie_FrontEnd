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
        Uri.parse('${api.googleTranslateApi}?text=$text&tl=$tl&sl=$sl'),
          headers: {
            "x-rapidapi-host": "google-translate20.p.rapidapi.com",
            "x-rapidapi-key": "abbc3a358fmsh669b0ad9ae76e82p1eb728jsnb3eb9cfd6b5d",
          },
      ).timeout(const Duration(seconds: 10));

      final responseBody = json.decode(response.body);
      this._statusCode = responseBody['code'];

      if (this._statusCode != 200) this._message = 'Translate text fail';
      else {
        this._message = 'Translate text success';
         translatedText = responseBody['data']['translation'];
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