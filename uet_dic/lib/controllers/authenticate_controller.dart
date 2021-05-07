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
  int _statusCode; // status code of response from server

  AuthenticateController() {
    this._user = null;
    this._message = '';
    this._statusCode = 400;
  }

  User get currentUser => this._user;
  String get message => this._message;
  int get statusCode => this._statusCode;

  /// this function create an anonymous user when user don't have account
  /// and want to use without create user
  Future<int> signInAnonymously() async {
    try {
      /// check internet connection
      await InternetAddress.lookup('example.com');

      this._user = new User(
          username: 'Anonymous user', email: 'anonymous email', wordIdList: []);

      this._message = "Sign in anonymously";
      this._statusCode = 200;
      print('Sign in anonymously success!');

      /// notify the listener that user has changed
      this.notifyListeners();
    } catch (error) {
      this._message = "Please check your network or try later";
      this._statusCode = 400;
      print("Sign in anonymously error: ${error.toString()}!");
    }

    showToast(this.message, this.statusCode);
    return this._statusCode;
  }

  /// sign in with email and pass word
  /// if success sever will send back a token:
  ///     response body = {accessToken = '...'}
  ///     status code = 200
  /// if fails:
  ///     response body = {accessToken: null, message: ...}
  ///      status code >= 400
  Future<int> signInWithEmailAndPassword(
      String _email, String _password) async {
    try {
      print('Sign in with email and password ... ');

      final http.Response response = await http.post(
        Uri.parse(api.signInApi),
        body: {'email': _email, 'password': _password},
      ).timeout(const Duration(seconds: 5));

      final responseBody = json.decode(response.body);
      this._statusCode = response.statusCode;

      if (this._statusCode == 200) {
        final String token = responseBody['accessToken'];
        this.saveAccessToken(token);

        this._statusCode = await signInWithToken();
        return this._statusCode;
      } else {
        this._user = null;
        this._message = responseBody['message'] == null
            ? responseBody['details'][0]['message']
            : responseBody['message'];
        print('Sign in with email and password fail: ${this._message}');
      }
    } catch (error) {
      print('Sign in with email and password error: ${error.toString()}');
      this._message = "Please check your network or try later";
      this._statusCode = 400;
    }

    showToast(this._message, this._statusCode);
    return this._statusCode;
  }

  /// sign in with token store in secure storage
  Future<int> signInWithToken() async {
    final storage = new FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    if (token == null) return this._statusCode = 400;

    try {
      final response = await http.get(
        Uri.parse(api.userApi),
        headers: {'x-access-token': token},
      ).timeout(const Duration(seconds: 3));

      final _responseBody = json.decode(response.body);
      this._statusCode = response.statusCode;

      if (this._statusCode == 200) {
        this._user = User.fromJson(_responseBody);
        this._message = "Welcome ${this._user.username}!";
        print('Sign in with token success: ${this._user.username}');

        this.notifyListeners();
      } else {
        this._user = null;
        this._message = _responseBody['message'] == null
            ? _responseBody['details'][0]['message']
            : _responseBody['message'];
        print('Sign in with token fail: ${this._message}');
      }
    } catch (err) {
      print('Sign in with token error: ${err.toString()}');
      this._message = "Please check your network or try later";
      this._statusCode = 400;
    }
    showToast(this._message, this._statusCode);
    return this._statusCode;
  }

  void saveAccessToken(String accessToken) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'token', value: accessToken);
  }

  /// sign up with email and password
  Future<int> signUpWithEmailAndPassword(String username,
      String email, String password, String confirmPassword) async {
    try {
      print('Registering user .... ');
      var response = await http.post(
        Uri.parse(api.signUpApi),
        body: {
          'username': username,
          'email': email,
          'password': password,
          'repeat_password': confirmPassword
        },
      ).timeout(const Duration(seconds: 3));

      final _responseBody = json.decode(response.body);
      this._statusCode = response.statusCode;
      this._message = _responseBody['message'] == null
          ? _responseBody['details'][0]['message']
          : _responseBody['message'];

      print('Sign up result: ${this._message}');

    } catch (err) {
      print('sign up with email and password error: ${err.toString()}');
      this._message = "Please check your network or try later";
      this._statusCode = 400;
    }

    showToast(this._message, this._statusCode);
    return this._statusCode;
  }

  /// sign out
  Future<void> signOut() async {

    final storage = new FlutterSecureStorage();
    await storage.delete(key: 'token');

    this._user = null;
    this._statusCode = 400;
    this._message = 'Sign out';
    print("Sign out");

    this.notifyListeners();
    showToast(this._message, this._statusCode);
  }
}
