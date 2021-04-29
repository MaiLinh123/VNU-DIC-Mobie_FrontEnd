import 'dart:io';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';

import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/share/app_background.dart';
import 'package:uet_dic/share/app_card.dart';
import 'package:uet_dic/share/app_loading.dart';
import 'package:uet_dic/views/authenticate_views/authShare.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInScreen extends StatefulWidget {
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
    if (_loading) return AppLoading();

    print('Sign In Screen');
    final _authenticateController =
        Provider.of<AuthenticateController>(context);

    final _emailField = myTextFormField(
      controller: _emailController,
      validator: (value) {
        if (value.isEmpty) return "Please enter your email";
        return null;
      },
      iconData: Icons.email_rounded,
      hintText: "Enter email",
    );
    final _passwordField = myTextFormField(
      obscureText: true,
      controller: _passwordController,
      validator: (value) {
        if (value.isEmpty) return "Please enter your password";
        return null;
      },
      iconData: Icons.vpn_key,
      hintText: "Enter password",
    );

    final _signInButton = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        myElevatedButton(
          child: Text('Sign in'),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              setState(() => this._loading = true);
              Map<String, dynamic> result =
                  await _authenticateController.signInWithEmailAndPassword(
                      _emailController.text, _passwordController.text);
              if (result['statusCode'] != 200) {
                setState(() {
                  this._loading = false;
                });
              }
            }
          },
        ),
        Text('or'),
        // start now button
        myElevatedButton(
          child: Text('Start now'),
          onPressed: () async {
            setState(() => this._loading = true);
            Map<String, dynamic> result =
                await _authenticateController.signInAnonymously();
            if (result['statusCode'] != 200) {
              setState(() {
                this._loading = false;
              });
            }
          },
        ),
      ],
    );
    final _signUpButton = myElevatedButton(
      child: Text('Create New Account'),
      onPressed: () {
        Navigator.pushNamed(context, '/signup');
      },
    );
    final _signInForm = Form(
      key: _formKey,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          _emailField,
          SizedBox(height: 10),
          _passwordField,
          SizedBox(height: 23),
          _signInButton,
          SizedBox(height: 10),
          Divider(color: Colors.grey[800]),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: _signUpButton,
          ),
        ],
      ),
    );
    final _signInBody = AppBackGround(
      aboveBackground: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: KeyboardAvoider(
          child: AppCard(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: _signInForm)),
        ),
      ),
    );

      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: _signInBody);
  }
}
