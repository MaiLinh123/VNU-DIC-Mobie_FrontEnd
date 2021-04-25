import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/share/loading.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

class SignUpScreen extends StatefulWidget {

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  String _error = '';
  bool _loading = false;

  final _appBar = AppBar(
    brightness: Brightness.light,
    elevation: 0,
    title: Text('Sign up'),
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

    print('Sign Up Screen');

    final _authenticateController = Provider.of<AuthenticateController>(context);

    final _nameField = SizedBox(
        child: TextFormField(
            controller: _nameController,
            validator: FormBuilderValidators.required(context, errorText: "Please enter your name"),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_circle,
                color: Colors.green[400],
              ),
              enabledBorder: _outlineInputBorder,
              focusedBorder: _outlineInputBorder,
              errorBorder: _outlineInputBorder,
              focusedErrorBorder: _outlineInputBorder,
              hintText: "Enter name",
              alignLabelWithHint: false,
            )));
    final _emailField = SizedBox(
        child: TextFormField(
            controller: _emailController,
            validator: FormBuilderValidators.required(context, errorText: "Please enter your correct email"),
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
            validator: FormBuilderValidators.required(context, errorText: "Please enter a password"),
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
    final _passwordConfirmField = SizedBox(
        child: TextFormField(
            obscureText: true,
            controller: _passwordConfirmController,
            validator: (value) {
              if(value != _passwordController.text) return 'Confirm password incorrect';
              return null;
            },
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
              hintText: "Confirm your password",
            )));
    final _errorNotify = Text(
      _error,
      style: TextStyle(color: Colors.red, fontSize: 14),
    );
    final _signUpButton = SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            child: Text('Sign up'),
            style: ElevatedButton.styleFrom(
              primary: Colors.green[400], //background
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              padding: EdgeInsets.all(15.0),
            ),
            onPressed: () async {
              // validate return true if the form is correct, false if other
              if (_formKey.currentState.validate()) {
                setState(() {
                  _loading = true;
                });
                try {
                  await InternetAddress.lookup('google.com');
                  Map<String, dynamic> result =
                      await _authenticateController.signUpWithEmailAndPassword(
                          _nameController.text,
                          _emailController.text,
                          _passwordController.text,
                          _passwordConfirmController.text);
                  if (result['statusCode'] != 200) {
                    setState(() {
                      print('Error sign up: ${result['message']}');
                      _error = result['message'];
                      _loading = false;
                    });
                  } else {
                    print('${result['message']} -> sign in screen');
                    Navigator.pop(context);
                  }
                } on SocketException catch (e) {
                  print(e);
                  setState(() {
                    _error = "Error! please check your network or try later";
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
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Sign in',
              style: TextStyle(color: Colors.green[400], fontSize: 16)),
        ),
      ],
    );

    return _loading
        ? Loading()
        : Scaffold(
            appBar: _appBar,
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                child: FormBuilder(
                  key: _formKey,
                  child: Column(children: [
                    _nameField,
                    SizedBox(height: 10),
                    _emailField,
                    SizedBox(height: 10),
                    _passwordField,
                    SizedBox(height: 10),
                    _passwordConfirmField,
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