import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uet_dic/models/word_model.dart';
import 'package:uet_dic/share/app_api.dart' as api;
import 'package:uet_dic/share/app_loading.dart';

class WordController with ChangeNotifier {
  /// recentWordsList is a string list of the encode of recent queried word
  /// example: recentWordsList = [ '{"word":"word1","phonetic":"/phonetic1/","audio":"audio1"}', ... ]
  List<String> recentWordsList;
  String _message;
  int _statusCode;

  WordController() {
    this.recentWordsList = [];
    this.getRecentWords();
    this._message = '';
    this._statusCode = 400;
  }

  /// Query word by word
  Future<Map<String, dynamic>> queryWord(String queryWord) async {
    print('Query word: $queryWord');
    List<Word> wordsList = [];
    try {
      /// validate word before search
      queryWord = queryWord.trim().toLowerCase();
      /// get word from sever
      final response = await http.get(
        Uri.parse('${api.wordQueryApi}$queryWord'),
      ).timeout(const Duration(seconds: 3));
      /// convert json response to Word object
      List<dynamic> mapWordsList = json.decode(response.body)['words'];
      for (final word in mapWordsList) {
        wordsList.add(Word.fromJson(word));
      }

      if (wordsList.isEmpty) {
        this._message = "Word not found!";
        this._statusCode = 400;
        print('Word not found!');
      } else {
        this._message = "Word gets success!";
        this._statusCode = response.statusCode;
        print('Word gets success!');
        this.updateRecentWords(
          queryWord: queryWord,
          phonetic: wordsList[0].phonetic,
        );
      }
    } catch (err) {
      this._message = 'Check your internet or try later';
      this._statusCode = 400;
      print('Query word: $err');
    }

    showToast(this._message, this._statusCode);
    return {
      'queriedWordsList': wordsList,
      'statusCode': this._statusCode
    };
  }

  /// update recent words:
  void updateRecentWords({String queryWord, Phonetic phonetic}) async {
    String recentWord = json.encode({
      'word': queryWord,
      'phonetic': phonetic.text,
      'audio': phonetic.audio,
    });
    print('Updating word $recentWord');
    /// if word existed in recent words list => remove and add to end list
    /// else add that word to end list
    this.recentWordsList.remove(recentWord);
    /// if length of list > 20 remove word at first
    if (this.recentWordsList.length > 20) this.recentWordsList.removeAt(0);
    this.recentWordsList.add(recentWord);

    /// save recent list to share storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('recentWords', this.recentWordsList);
    this.notifyListeners();
  }

    /// get recent words list from share storage
  void getRecentWords() async {
    print('Getting recent word ... ');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.recentWordsList = prefs.getStringList('recentWords');
    if (this.recentWordsList == null) this.recentWordsList = [];
    print('Done');
    this.notifyListeners();
  }
}
