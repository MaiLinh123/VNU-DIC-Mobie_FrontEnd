import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uet_dic/share/app_api.dart' as api;
import 'package:uet_dic/share/app_loading.dart';

class WordController with ChangeNotifier{

  List<String> _recentWords;
  String _message;
  int _statusCode;

  WordController() {
    this._recentWords = [];
    this.getRecentWords();
    this._message = '';
    this._statusCode = 400;
  }

  List<String> get recentWord {
    return this._recentWords;
  }

  Future<Map<String, dynamic>> queryWord(String wordSearch) async {
    List<dynamic> _queriedWordList = [];
    try {
      wordSearch = wordSearch.trim().toLowerCase();
      print('Query: $wordSearch');

      final url = Uri.parse('${api.wordQueryApi}$wordSearch');
      final response = await http.get(url).timeout(const Duration(seconds: 2));

      _queriedWordList = json.decode(response.body)['words'];

      if (_queriedWordList.isEmpty) {
        this._message = "Word not found!";
        this._statusCode = 400;
        print('Word not found!');
      } else {
        this._message = "Word gets success!";
        this._statusCode = response.statusCode;
        print('Word gets success!');
        this.updateRecentWords(
          word: wordSearch,
          phonetic: _queriedWordList[0]['phonetics'],
        );
      }
    } catch (err) {
      this._message = 'Check your internet or try later';
      this._statusCode = 400;
      print('Error: $err');
    }
    showToast(this._message, this._statusCode);
    return {'words' : _queriedWordList, 'statusCode': this._statusCode, 'message':this._message};
  }

  void updateRecentWords({String word, List phonetic}) async {
    String recentWord = json.encode({
      'word':word,
      'phonetic':phonetic.isEmpty ? '' : phonetic[0]['text'],
      'audio':phonetic.isEmpty ? '' : phonetic[0]['audio'],
    });
    print('Updating word $recentWord ... ');
    this._recentWords.remove(recentWord);
    if(this._recentWords.length > 20) this._recentWords.removeAt(0);
    this._recentWords.add(recentWord);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('recentWords', this._recentWords);
    this.notifyListeners();
  }
  void getRecentWords() async {
    print('Getting recent word ... ');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this._recentWords = prefs.getStringList('recentWords');
    if(this._recentWords == null) this._recentWords = [];
    print('Done');
    this.notifyListeners();
  }

}