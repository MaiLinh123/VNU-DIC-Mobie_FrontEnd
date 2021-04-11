import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vnu_dic/controllers/authenticate_controller.dart';
import 'package:vnu_dic/share/loading.dart';


class SignInScreen extends StatefulWidget {
  final Function toggleView;
  SignInScreen({this.toggleView});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _loading = false;


  @override
  Widget build(BuildContext context) {
    final _authenticateController = Provider.of<AuthenticateController>(context);
    String _error = _authenticateController.message;
    print('Sign In Screen');

    final _appBar = AppBar(
      /*elevation: 0.0,*/
      title: Text('VNU_DIC'),

    );

    final _emailField = TextFormField(
      decoration: InputDecoration(
        hintText: 'Email',
      ),
      controller: _emailController,
      validator: (value) {
        if (value.isEmpty || !value.contains('@')) {
          return "Please enter the correct email";
        }
        return null;
      },
    );

    final _passwordField = TextFormField(
      obscureText: true,
      controller: _passwordController,
      decoration: InputDecoration(
        hintText: 'Password',
      ),
      validator: (value) {
        if (value.isEmpty) return "Please enter the password";
        return null;
      },
    );

    final _signInButton = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            child: Text('Sign in'),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                setState(() {
                  this._loading = true;
                });
                try {
                  await InternetAddress.lookup('google.com');
                  int result =
                  await _authenticateController.signInWithEmailAndPassword(
                      _emailController.text, _passwordController.text);
                  if (result == 400)
                    setState(() {
                      this._loading = false;
                    });
                } on SocketException catch (e) {
                  print(e.toString());
                  setState(() {
                    _error = "Error! please check your network or try later";
                    this._loading = false;
                  });
                }
              }
            }),
        Text('or'),
        // start now button
        ElevatedButton(
            child: Text('Start now'),
            onPressed: () async {
              setState(() {
                this._loading = true;
              });
              try {
                await InternetAddress.lookup('google.com');
                _authenticateController.signInAnonymously();
              } on SocketException catch (e) {
                print(e.toString());
                setState(() {
                  _error = "Error! please check your network or try later";
                  this._loading = false;
                });
              }
            })
      ],
    );

    final _errorNotify = Text(
      _error,
      style: TextStyle(
        color: _authenticateController.statusCode < 400 ? Colors.green : Colors.red,
        fontSize: 14,
      ),
    );

    final _signUpButton = ElevatedButton(
      onPressed: () {
        widget.toggleView();
      },
      child: Text('Create New Account'),
      style: ElevatedButton.styleFrom(primary: Colors.green),
    );

    return _loading
        ? Loading()
        : Scaffold(
        appBar: _appBar,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _emailField,
                  SizedBox(height: 10),
                  _passwordField,
                  SizedBox(height: 13),
                  _errorNotify,
                  SizedBox(height: 10),
                  _signInButton,
                  SizedBox(height: 10),
                  Divider(
                    color: Colors.grey[800],
                  ),
                  SizedBox(height: 10),
                  _signUpButton,
                ],
              ),
            ),
          ),
        ));
  }
}
