import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:uet_dic/share/app_api.dart' as api;
import 'package:uet_dic/share/app_loading.dart';

class User {
  String _email;
  String _username;
  Map<String, dynamic> _words;
  bool isWordsGot = false;

  User({String username, String email, List words}) {
    this._email = email;
    this._username = username;
    this._words = {};
    for (final wordID in words) {
      this._words['$wordID'] = wordID;
    }

    print('Create user successful : ${this.username}');
  }

  String get email {
    return this._email;
  }

  String get username {
    return this._username;
  }

  Map<String, dynamic> get words {
    return this._words;
  }

  factory User.fromJson(Map<String, dynamic> partedJson) {
    return User(
      username: partedJson['username'],
      email: partedJson['email'],
      words: partedJson['words'],
    );
  }

  bool checkExistWord(String wordID) {
    return this._words['$wordID'] != null;
  }

  Future<int> favouriteWord(Map<String, dynamic> word) async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    if (token != null) {
      print('token was found in local storage');
      try {
        await InternetAddress.lookup('example.com');
        var url = Uri.parse(api.userWordApi);

        var response = await http.put(
          url,
          headers: {'x-access-token': token},
          body: {"wordId": word['_id']},
        ).timeout(const Duration(seconds: 2));
        if (response.statusCode == 200) this._words['${word['_id']}'] = word;

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
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    if (token != null) {
      print('token was found in local storage');
      try {
        await InternetAddress.lookup('example.com');
        var url = Uri.parse(api.userWordApi);

        var response = await http.delete(
          url,
          headers: {'x-access-token': token},
          body: {"wordId": wordID},
        ).timeout(const Duration(seconds: 2));
        if (response.statusCode == 200) this._words.remove(wordID);
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

  Future<List<Map<String, dynamic>>> getWordListByID() async {
    List<Map<String, dynamic>> favouriteList = [];
    if (!this.isWordsGot) {
      print('Getting favourite words ... ');
      try {
        for (var entry in this.words.entries) {
          if (entry.key != entry.value) continue;
          final url = Uri.parse('${api.wordIDQueryApi}${entry.key}');
          final response =
              await http.get(url).timeout(const Duration(milliseconds: 500));
          if (response.statusCode == 200) {
            final Map<String, dynamic> _queriedByID =
                json.decode(response.body)['word'];
            this.words[entry.key] = _queriedByID;
          } else {
            this.words.remove(entry.key);
            this.unFavouriteWord(entry.key);
          }
        }
        this.isWordsGot = true;
        print('Done');
      } catch (err) {
        print("Error: ${err.toString()}");
        showToast("Check your internet or try later", 400);
        return favouriteList;
      }
    }
    this
        .words
        .entries
        .forEach((e) => favouriteList.add({'id': e.key, 'word': e.value}));
    return favouriteList;
  }

  Future<int> updatePassword(String oldPassword, String newPassword, String confirmPassword) async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    String message = '';
    int statusCode = 400;
    if(token != null) {
      var url = Uri.parse(api.userApi);
      try {
        print('Update user password .... ');
        var response = await http.put(
          url,
          headers: {
            'x-access-token' : token,
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
        print("Error: ${err.toString()}");
        message = "Check your internet or try later";
      }
    } else {
      print('Please sign in!');
      message = "Please sign in!";
    }
    showToast(message, statusCode);
    return statusCode;
  }

  String userInformation() {
    return 'email: ${this.email}, username: ${this.username}, words: ${this.words}';
  }
}
