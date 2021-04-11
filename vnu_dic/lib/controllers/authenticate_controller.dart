import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vnu_dic/models/user_model.dart';



class AuthenticateController with ChangeNotifier{
  User _user;
  String _message;
  int _statusCode;

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
    this._user = new User(
        email: '',
        password: null,
        information: {'name':'anonymousUser'}
    );
    this._message = "Sign in anonymously";
    this.notifyListeners();
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String _email, String _password) async {
    var url = Uri.parse('http://192.168.2.102:3333/signin');
    var response = await http.post(url, body: {'email': _email, 'password': _password});
    this._statusCode = response.statusCode;
    if(response.statusCode == 400) {
      this._user = null;
      this._message = response.body;
    } else {
      final Map parsed = json.decode(response.body);
      this._user = User.fromJson(parsed);
      this._message = "Sign in with email and password";
      this.notifyListeners();
    }
    return this._statusCode;
  }

  // sign up with email and password
  Future signUpWithEmailAndPassword(String _name, String _email, String _password) async {
    var url = Uri.parse('http://192.168.2.102:3333/signup');
    var response = await http.post(url, body: {
      'name':_name,'email': _email, 'password': _password
    });
    this._statusCode = response.statusCode;
    this._message = response.body;
    return response.statusCode;
  }

  // sign out
  Future signOut() async {
    this._user = null;
    this._statusCode = 400;
    this._message = '';
    this.notifyListeners();
  }

}