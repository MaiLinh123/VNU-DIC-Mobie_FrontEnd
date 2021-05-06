import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uet_dic/share/app_api.dart' as api;
import 'package:uet_dic/share/app_loading.dart';

class TranslateController {
  String _message;
  int _statusCode;

  Future<String> translateText(String text, String sl, String tl) async {
    String _translatedText = text;
    try {
      text = text.trim();
      print('Translating ...');

      final url = Uri.parse('${api.googleTranslateApi}?text=$text&tl=$tl&sl=$sl');
      final response = await http.get(
          url,
          headers: {
            "x-rapidapi-host": "google-translate20.p.rapidapi.com",
            "x-rapidapi-key": "abbc3a358fmsh669b0ad9ae76e82p1eb728jsnb3eb9cfd6b5d",
          },
      ).timeout(const Duration(seconds: 10));
      final _responseBody = json.decode(response.body);
      this._statusCode = _responseBody['code'];

      if (this._statusCode != 200) {
        this._message = 'Cant translate text';
      } else {
        this._message = 'Translate text success';
         _translatedText = _responseBody['data']['translation'];
      }
    } catch (err) {
      this._message = 'Check your internet or try later';
      print('Error: $err');
    }
    showToast(this._message, this._statusCode);
    return _translatedText;
  }
}