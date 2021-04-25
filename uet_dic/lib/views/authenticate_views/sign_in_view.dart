import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/share/loading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;
  String _error = '';

  final _appBar = AppBar(
    brightness: Brightness.light,
    elevation: 0,
    title: Text('Sign in'),
    backgroundColor: Colors.green[400],
  );
  final _outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
        color: Colors.green[400],
        width: 2.0,
      ));

  @override
  Widget build(BuildContext context) {
    print('Sign In Screen');
    final _authenticateController =
        Provider.of<AuthenticateController>(context);
    if (this._error == '') {
      this._error = _authenticateController.message;
    }

    final _emailField = SizedBox(
        child: TextFormField(
            controller: _emailController,
            validator: FormBuilderValidators.required(context,
                errorText: "Please enter your email"),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email_rounded,
                color: Colors.green[400],
              ),
              enabledBorder: _outlineInputBorder,
              focusedBorder: _outlineInputBorder,
              errorBorder: _outlineInputBorder,
              focusedErrorBorder: _outlineInputBorder,
              hintText: "Enter email",
              alignLabelWithHint: false,
            )));

    final _passwordField = SizedBox(
        child: TextFormField(
            obscureText: true,
            controller: _passwordController,
            validator: FormBuilderValidators.required(context,
                errorText: "Please enter your password"),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.vpn_key,
                color: Colors.green[400],
              ),
              enabledBorder: _outlineInputBorder,
              focusedBorder: _outlineInputBorder,
              errorBorder: _outlineInputBorder,
              focusedErrorBorder: _outlineInputBorder,
              hintText: "Enter password",
              alignLabelWithHint: false,
            )));

    final _errorNotify = Text(
      _error,
      style: TextStyle(
        color: _authenticateController.statusCode == 200
            ? Colors.green
            : Colors.red,
        fontSize: 14,
      ),
    );

    final _signInButton = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            child: Text('Sign in'),
            style: ElevatedButton.styleFrom(
              primary: Colors.green[400], //background
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              padding: EdgeInsets.all(15.0),
            ),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                setState(() {
                  this._loading = true;
                });
                try {
                  await InternetAddress.lookup('google.com');
                  Map<String, dynamic> result =
                      await _authenticateController.signInWithEmailAndPassword(
                          _emailController.text, _passwordController.text);
                  if (result['statusCode'] != 200) {
                    setState(() {
                      this._loading = false;
                      this._error = result['message'];
                    });
                  }
                } on SocketException catch (e) {
                  print(e.toString());
                  setState(() {
                    this._error = "Error! please check your network or try later";
                    this._loading = false;
                  });
                }
              }
            }),
        Text('or'),
        // start now button
        ElevatedButton(
            child: Text('Start now'),
            style: ElevatedButton.styleFrom(
              primary: Colors.green[400], //background
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              padding: EdgeInsets.all(15.0),
            ),
            onPressed: () async {
              setState(() {this._loading = true;});
              try {
                await InternetAddress.lookup('google.com');
                _authenticateController.signInAnonymously();
              } on SocketException catch (e) {
                print(e.toString());
                setState(() {
                  this._error = "Error! please check your network or try later";
                  this._loading = false;
                });
              }
            })
      ],
    );

    final _signUpButton = ElevatedButton(
      onPressed: () {
        this._error = '';
        Navigator.pushNamed(context, '/signup');
      },
      child: Text('Create New Account'),
      style: ElevatedButton.styleFrom(
        primary: Colors.green[400], //background
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.all(15.0),
      ),
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
