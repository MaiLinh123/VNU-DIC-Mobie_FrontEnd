import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uet_dic/share/app_api.dart' as api;
import 'package:uet_dic/share/app_loading.dart';

class WordController with ChangeNotifier{

  List _searchWords;
  List<String> _recentWords;
  String _message;
  int _statusCode;

  WordController() {
    this._searchWords = [];
    this._recentWords = [];
    updateRecentWords(null);
    this._message = '';
    this._statusCode = 400;
  }

  List get recentWord {
    return this._recentWords;
  }

  Future<Map<String, dynamic>> getWord(String wordSearch) async {
    wordSearch = _validateBeforeSearch(wordSearch);
    try {
      await InternetAddress.lookup('example.com');

      final url = Uri.parse('${api.wordApi}$wordSearch');
      final response = await http.get(url).timeout(const Duration(seconds: 3));

      this._searchWords = json.decode(response.body)['words'];

      if(this._searchWords.isEmpty) {
        this._message = "Word not found!";
        this._statusCode = 400;
        print('Word not found!');
      } else {
        this._message = "Word gets success!";
        this._statusCode = response.statusCode;
        this.updateRecentWords(wordSearch);
        print('Word gets success!');
      }
    } on TimeoutException catch (err) {
      print('Time out error, something wrong: $err');
      this._message = 'Timeout Error! Try later.';
      this._statusCode = 400;
    } on SocketException catch (err) {
      print('Time out error, something wrong: $err');
      this._message = 'Network Error! Check your internet.';
      this._statusCode = 400;
    } catch (err) {
      print('Error, something wrong: $err');
      this._message = 'Error! Try again.';
      this._statusCode = 400;
    }
    showToast(this._message, this._statusCode);
    return {'words' : this._searchWords, 'statusCode': this._statusCode, 'message':this._message};
  }
  String _validateBeforeSearch(String words) {
    return words.trim().toLowerCase();
  }
  void updateRecentWords(String wordSearch) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this._recentWords = prefs.getStringList('recentWords');

    if(this._recentWords == null) this._recentWords = [];

    if(wordSearch != null) {
      for(String word in this._recentWords) {
        if(word == wordSearch) return;
      }
      if(this._recentWords.length > 20) this._recentWords.removeAt(0);
      this._recentWords.add(wordSearch);
      prefs.setStringList('recentWords', this._recentWords);
      this.notifyListeners();
    }
  }
}