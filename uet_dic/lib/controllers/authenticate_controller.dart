import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:uet_dic/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uet_dic/share/app_api.dart' as api;
import 'package:uet_dic/share/app_loading.dart';

class AuthenticateController with ChangeNotifier {
  User _user; // current user
  String _message; // the message response from server
  int _statusCode; // status code

  AuthenticateController() {
    this._user = null;
    this._message = '';
    this._statusCode = 400;
  }

  User get currentUser {
    return this._user;
  }

  String get message {
    return this._message;
  }

  int get statusCode {
    return this._statusCode;
  }

  // sign in anonymous
  Future<Map<String, dynamic>> signInAnonymously() async {
    try {
      await InternetAddress.lookup('example.com');
      this._user = new User(username: 'anonymous user',email: 'anonymous email',  words: []);
      this._message = "Sign in anonymously";
      this._statusCode = 200;
      print('Sign in anonymously');
      this.notifyListeners();
    } catch (err) {
      print(err.toString());
      this._message = "Please check your network or try later";
      this._statusCode = 400;
    }
    showToast(this.message, this.statusCode);
    return {'statusCode': this._statusCode, 'message': this._message};
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String _email, String _password) async {
    var url = Uri.parse(api.signInApi);
    try {
      print('Sign in with email and password ... ');
      var response = await http.post(url, body: {
        'email': _email,
        'password': _password
      }).timeout(const Duration(seconds: 5));

      final _responseBody = json.decode(response.body);
      this._statusCode = response.statusCode;

      if (this._statusCode != 200) {
        this._user = null;
        this._message = _responseBody['message'] == null
            ? _responseBody['details'][0]['message']
            : _responseBody['message'];
        print('Sign in fail: ${this._message}');
        showToast(this._message, this._statusCode);
      } else {
        final String token = _responseBody['accessToken'];
        print('Get access token success!');
        saveAccessToken(token);
        await signInWithToken();

        this._message = 'Sign in success';
        showToast(this._message, this._statusCode);
      }
    } catch (err) {
      print(err.toString());
      this._message = "Please check your network or try later";
      this._statusCode = 400;
      showToast(this._message, this._statusCode);
    }
    return {'statusCode': this._statusCode, 'message': this._message};
  }

  Future<Map<String, dynamic>> signInWithToken() async {
    final storage = new FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    if(token != null) {
      print('token was found in local storage');
      try {
        var url = Uri.parse(api.userApi);
        print('getting user with token ....');
        var response = await http.get(
          url,
          headers: {'x-access-token': token},
        ).timeout(const Duration(seconds: 10));
        final _responseBody = json.decode(response.body);
        if (response.statusCode != 200) {
          this._user = null;
          this._message = _responseBody['message'] == null
              ? _responseBody['details'][0]['message']
              : _responseBody['message'];
          print('Sign in with token fail: ${this._message}');
        } else {
          this._user = User.fromJson(_responseBody);
          this._message = "Welcome ${this._user.username}!";
          print('Sign in with token success: ${this._user.username}');
          this.notifyListeners();
        }
        this._statusCode = response.statusCode;
      } catch (err) {
        print(err.toString());
        this._message = "Please check your network or try later";
        this._statusCode = 400;
      }
      showToast(this._message, this._statusCode);
    }
    return {'statusCode': this._statusCode, 'message': this._message};
  }

  void saveAccessToken(String accessToken) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'token', value: accessToken);
    print('Save access token!');
  }

  // sign up with email and password
  Future<Map<String, dynamic>> signUpWithEmailAndPassword(String _username, String _email,
      String _password, String _confirmPassword) async {
    var url = Uri.parse(api.signUpApi);
    try {
      print('Registering user .... ');
      var response = await http.post(url, body: {
        'username': _username,
        'email': _email,
        'password': _password,
        'repeat_password': _confirmPassword
      }).timeout(const Duration(seconds: 5));
      final _responseBody = json.decode(response.body);
      this._statusCode = response.statusCode;
      this._message = _responseBody['message'] == null
          ? _responseBody['details'][0]['message']
          : _responseBody['message'];
      print('Sign up result: ${this._message}');
      this.notifyListeners();
    } catch (err) {
      print(err.toString());
      this._message = "Error! please check your network or try later";
      this._statusCode = 400;
    }
    showToast(this._message, this._statusCode);
    return {'statusCode': this._statusCode, 'message': this._message};
  }

  // sign out
  Future<void> signOut() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: 'token');
    this._user = null;
    this._statusCode = 400;
    this._message = 'Sign out';
    this.notifyListeners();
    showToast(this._message, this._statusCode);

    print("Sign out");
  }
}
