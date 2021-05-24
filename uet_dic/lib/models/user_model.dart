import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:uet_dic/models/word_model.dart';
import 'package:uet_dic/share/app_api.dart' as api;
import 'package:uet_dic/share/app_loading.dart';

class User {
  String _email;
  String _username;
  Map<String, dynamic> _wordIdMap;
  bool _isWordsGot = false;

  User({String username, String email, List wordIdList}) {
    /// wordIdList is response from sever: wordIdList = [id1, id2, id3, .... ]
    this._email = email;
    this._username = username;

    /// wordIdList = [id1, id2, id3, .... ]
    /// if isWordsGot = false => _wordIdMap = {id1:id1, id2:id2, ... }
    /// if isWordsGot = true  => _wordIdMap = {id1:word1, id2:word2, ... } (this means all words are gotten from sever)
    /// use Map for easy check as if a word is in saved or not
    this._wordIdMap = {};
    for (final wordId in wordIdList) this._wordIdMap['$wordId'] = wordId;

    print('Create user successful : ${this.username}');
  }

  String get email => this._email;
  String get username => this._username;
  Map<String, dynamic> get wordIdMap => this._wordIdMap;

  factory User.fromJson(Map<String, dynamic> partedUserJson) {
    /// partedUserJson is response from server when getting user by token
    /// partedUserJson = {username: example_username, email: example@gmail.com, roles: [ROLE_USER], words: [id1, id2, ... ]}
    return User(
      username: partedUserJson['username'],
      email: partedUserJson['email'],
      wordIdList: partedUserJson['words'],
    );
  }

  bool checkExistWord(String wordId) => this._wordIdMap['$wordId'] != null;

  Future<int> favouriteWord(Word word) async {
    print('Saved word ${word.word}');
    /// get token from secure storage
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    if (token != null) {
      try {
        /// put word to favourite word on sever
        final response = await http.put(
          Uri.parse(api.userWordApi),
          headers: {'x-access-token': token},
          body: {"wordId": word.id},
        ).timeout(const Duration(seconds: 2));

        /// if word is put, update wordIdMap
        if (response.statusCode == 200) this._wordIdMap['${word.id}'] = word;

        print('${response.body}, ${response.statusCode}');
        showToast(json.decode(response.body)['message'], response.statusCode);

        return response.statusCode;
      } catch (err) {
        print("Please check your network or try later: ${err.toString()}");
        showToast("Check your internet or try later", 400);
      }
    } else {
      print('Please sign in!');
      showToast("Please sign in!", 400);
    }
    return 400;
  }

  Future<int> unFavouriteWord(String wordID) async {
    print('Delete word: $wordID');

    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    if (token != null) {
      try {
        var url = Uri.parse(api.userWordApi);

        var response = await http.delete(
          url,
          headers: {'x-access-token': token},
          body: {"wordId": wordID},
        ).timeout(const Duration(seconds: 2));

        if (response.statusCode == 200) this._wordIdMap.remove(wordID);

        showToast(response.body, response.statusCode);
        return response.statusCode;
      } catch (err) {
        print("Check your network or try later: ${err.toString()}");
        showToast("Check your internet or try later", 400);
      }
    } else {
      print('Please sign in!');
      showToast("Please sign in!", 400);
    }
    return 400;
  }

  /// get all words from sever
  Future<List<Word>> getFavouriteListByID() async {
    print('Getting favourite words ... ');

    List<Word> favouriteList = [];
    /// _isWordsGot = false means words aren't gotten, we need to query all now
    if (!this._isWordsGot) {
      try {
        for (final entry in this._wordIdMap.entries) {
          /// key != value means : this word was gotten
          if (entry.key != entry.value) continue;

          final response = await http
              .get(
                Uri.parse('${api.wordIDQueryApi}${entry.key}'),
              )
              .timeout(const Duration(seconds: 2));

          if (response.statusCode == 200)
            this._wordIdMap[entry.key] =
                Word.fromJson(json.decode(response.body)['word']);
          else {
            /// we need to remove all word which id doesn't exist in sever
            this._wordIdMap.remove(entry.key);
            await this.unFavouriteWord(entry.key);
          }
        }
        this._isWordsGot = true;
        print('Done');
      } catch (err) {
        print("Get words list error : ${err.toString()}");
        showToast("Check your internet or try later", 400);
        return favouriteList;
      }
    }
    /// return a list from map
    this._wordIdMap.forEach((key, value) => favouriteList.add(value));
    return favouriteList;
  }

  Future<int> updatePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    print('Update user password .... ');

    String message = '';
    int statusCode = 400;

    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    if (token != null) {
      try {
        var response = await http.put(
          Uri.parse(api.userApi),
          headers: {
            'x-access-token': token,
          },
          body: {
            'old_password': oldPassword,
            'password': newPassword,
            'repeat_password': confirmPassword,
          },
        ).timeout(const Duration(seconds: 5));

        message = json.decode(response.body)['message'];
        statusCode = response.statusCode;
        showToast(message, statusCode);

      } catch (err) {
        print("Update Password Error: ${err.toString()}");
        message = "Check your internet or try later";
      }
    } else {
      print('Please sign in!');
      message = "Please sign in!";
    }

    showToast(message, statusCode);
    return statusCode;
  }
}
