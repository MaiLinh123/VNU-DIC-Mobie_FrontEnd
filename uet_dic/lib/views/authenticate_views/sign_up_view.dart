import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/share/loading.dart';

class SignUpScreen extends StatefulWidget {
  final Function toggleView;
  SignUpScreen({this.toggleView});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _error = '';
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    print('Sign Up Screen');
    final _authenticateController = Provider.of<AuthenticateController>(context, listen: true);

    final _appBar = AppBar(
      elevation: 0.0,
      title: Text('Sign up'),
    );
    final _nameField = TextFormField(
      decoration: InputDecoration(
        hintText: 'Name',
      ),
      controller: _nameController,
      validator: (value) {
        if (value.isEmpty)
          return "Please enter your name";
        return null;
      },
    );

    final _emailField = TextFormField(
      decoration: InputDecoration(
        hintText: 'Email',
      ),
      controller: _emailController,
      validator: (value) {
        if (value.isEmpty)
          return "Please enter the email";
        else if (!value.contains('@')) return "Please enter the correct email";
        return null;
      },
    );

    final _passwordField = TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
      ),
      controller: _passwordController,
      validator: (value) {
        if (value.length < 6)
          return "Please enter a password more than 6 characters";
        return null;
      },
    );

    final _errorNotify = Text(
      _error,
      style: TextStyle(color: Colors.red, fontSize: 14),
    );

    final _signUpButton = SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            child: Text('Sign up'),
            style: ElevatedButton.styleFrom(primary: Colors.green),
            onPressed: () async {
              // validate return true if the form is correct, false if other
              if (_formKey.currentState.validate()) {
                setState(() {
                  _loading = true;
                });
                try {
                  await InternetAddress.lookup('google.com');
                  int result =
                  await _authenticateController.signUpWithEmailAndPassword(
                      _nameController.text,
                      _emailController.text,
                      _passwordController.text
                  );
                  if (result == 401) {
                    setState(() {
                      _error = _authenticateController.message;
                      _loading = false;
                    });
                  } else {
                      widget.toggleView();
                  }
                } on SocketException catch (e) {
                  print(e);
                  setState(() {
                    this._error = "Error! please check your network or try later";
                    _loading = false;
                  });
                }
              }
            }));

    final _backToSignIn = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already have account?'),
        TextButton(
          onPressed: () { widget.toggleView(); },
          child: Text('Sign in', style: TextStyle(color: Colors.blue, fontSize: 16)),
        ),
      ],
    );

    return _loading
        ? Loading()
        : Scaffold(
        appBar: _appBar,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
            child: Form(
              key: _formKey,
              child: Column(children: [
                _nameField,
                SizedBox(height: 10),
                _emailField,
                SizedBox(height: 10),
                _passwordField,
                SizedBox(height: 13),
                _errorNotify,
                SizedBox(height: 10),
                _signUpButton,
                _backToSignIn,
              ]),
            ),
          ),
        ));
  }
}