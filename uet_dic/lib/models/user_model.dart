import 'dart:async';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uet_dic/share/app_api.dart' as api;
import 'package:http/http.dart' as http;
import 'package:uet_dic/share/app_loading.dart';

class User {
  String _email;
  String _username;
  List _words;

  User({String username, String email, List words}) {
    this._email = email;
    this._username = username;
    this._words = words;

    print('Create user successful : ${this._username}');
  }

  String get email {
    return this._email;
  }

  String get username {
    return this._username;
  }

  List get words {
    return this._words;
  }

  Future<void> saveWords(String wordID) async {
    final storage = new FlutterSecureStorage();
    // get token from local storage
    final token = await storage.read(key: 'token');
    // if token found
    if(token != null) {
      print('token was found in local storage');
      try {
        await InternetAddress.lookup('example.com');
        var url = Uri.parse(api.wordApi);

        var response = await http.put(
          url,
          headers: {'x-access-token': token},
          body: {"wordId": wordID},
        ).timeout(const Duration(seconds: 10));
        print('${response.body}, ${response.statusCode}');
        // response from sever
        if (response.statusCode == 200) {
          this._words.add(wordID);
        }
        showToast(response.body, response.statusCode);
      } on TimeoutException catch (err) {
        print('Time out error, something wrong: ${err.toString()}');
        showToast('Save word fail!', 400);
      } on SocketException catch (err) {
        print("Error! please check your network or try later: ${err.toString()}");
        showToast("Error! please check your network or try later", 400);
      }
    }

  }


  factory User.fromJson(Map<String, dynamic> partedJson) {
    print(partedJson.toString());
    return User(
        username: partedJson['username'],
        email: partedJson['email'],
        words: partedJson['words'],
    );
  }

  String userInformation() {
    return 'email: ${this.email} \n username: ${this.username} \n words: ${this.words}';
  }
}