import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:uet_dic/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uet_dic/share/api.dart' as api;

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
  void signInAnonymously() {
    this._user = new User(email: '', username: 'anonymousUser', words: []);
    this._message = "Sign in anonymously";
    this._statusCode = 200;
    print('Sign in anonymously');
    this.notifyListeners();
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String _email, String _password) async {
    var url = Uri.parse(api.signInApi);
    try {
      // sign in by api
      print('Sign in with email and password ... ');
      var response = await http.post(url, body: {
        'email': _email,
        'password': _password
      }).timeout(const Duration(seconds: 5));
      // response body and status code
      final _responseBody = json.decode(response.body);
      this._statusCode = response.statusCode;
      // if login fail (status code > 400 )
      if (response.statusCode != 200) {
        this._user = null;
        this._message = _responseBody['message'] == null
            ? _responseBody['details'][0]['message']
            : _responseBody['message'];
        print('Sign in fail: ${this._message}');
      }
      // if login success (status code = 200)
      else {
        final String token = _responseBody['accessToken'];
        print('Get access token success!');
        saveAccessToken(token);
        this.notifyListeners();
      }
    } on TimeoutException catch (err) {
      print('Time out error, something wrong: $err');
      this._statusCode = 400;
      this._message = 'Time out error';
    }

    return {'statusCode': this._statusCode, 'message': this._message};
  }

  Future signInWithToken() async {
    final storage = new FlutterSecureStorage();
    // get token from local storage
    final token = await storage.read(key: 'token');
    // if token found
    if(token != null) {
      print('token was found in local storage');
      try {
        var url = Uri.parse(api.userApi);
        print('getting user with token ....');
        var response = await http.get(
          url,
          headers: {'x-access-token': token},
        ).timeout(const Duration(seconds: 10));
        // response from sever
        final _responseBody = json.decode(response.body);
        this._statusCode = response.statusCode;
        // sign in fail, status code > 400
        if (response.statusCode != 200) {
          this._user = null;
          this._message = _responseBody['message'] == null
              ? _responseBody['details'][0]['message']
              : _responseBody['message'];
          print('Sign in with token fail: ${this._message}');
        } else {
          this._user = User.fromJson(_responseBody);
          this._message = "Sign in success with token";
          print('Sign in with token success: ${this._user.username}');
          this.notifyListeners();
        }
      } on TimeoutException catch (err) {
        print('Time out error, something wrong');
        this._statusCode = 400;
        this._message = err.toString();
      }
    }
  }

  void saveAccessToken(String accessToken) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'token', value: accessToken);
    print('Save access token!');
  }

  // sign up with email and password
  Future signUpWithEmailAndPassword(String _username, String _email,
      String _password, String _confirmPassword) async {
    var url = Uri.parse(api.signUpApi);
    try {
      // sign up by api
      print('Registering user .... ');
      var response = await http.post(url, body: {
        'username': _username,
        'email': _email,
        'password': _password,
        'repeat_password': _confirmPassword
      }).timeout(const Duration(seconds: 5));
      // response from sever
      final _responseBody = json.decode(response.body);
      this._statusCode = response.statusCode;
      this._message = _responseBody['message'] == null
          ? _responseBody['details'][0]['message']
          : _responseBody['message'];
      print('Sign up result: ${this._message}');
      this.notifyListeners();
    } on TimeoutException catch (err) {
      print('Time out error, something wrong');
      this._statusCode = 400;
      this._message = err.toString();
    }
    return {'statusCode': this._statusCode, 'message': this._message};
  }

  // sign out
  Future signOut() async {
    final storage = new FlutterSecureStorage();
    storage.delete(key: 'token');
    this._user = null;
    this._statusCode = 400;
    this._message = '';
    this.notifyListeners();
    print("Sign out");
  }
}
