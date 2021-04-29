import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/share/app_background.dart';
import 'package:uet_dic/share/app_card.dart';
import 'package:uet_dic/share/app_loading.dart';

import 'authShare.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    if (_loading) return AppLoading();

    print('Sign Up Screen');

    final _authenticateController =
        Provider.of<AuthenticateController>(context);

    final _nameField = myTextFormField(
      controller: _nameController,
      validator: (value) {
        if (value.isEmpty) return "Please enter your name";
        return null;
      },
      hintText: "Enter name",
      iconData: Icons.account_circle,
    );

    final _emailField = myTextFormField(
      controller: _emailController,
      validator: (value) {
        if (value.isEmpty) return "Please enter your correct email";
        return null;
      },
      iconData: Icons.email_rounded,
      hintText: "Enter email",
    );

    final _passwordField = myTextFormField(
      obscureText: true,
      controller: _passwordController,
      validator: (value) {
        if (value.isEmpty) return "Please enter a password";
        return null;
      },
      iconData: Icons.vpn_key,
      hintText: "Enter password",
    );

    final _passwordConfirmField = myTextFormField(
      obscureText: true,
      controller: _passwordConfirmController,
      validator: (value) {
        if (value != _passwordController.text)
          return 'Confirm password incorrect';
        return null;
      },
      iconData: Icons.vpn_key,
      hintText: "Confirm your password",
    );


    final _signUpButton = myElevatedButton(
      child: Text('Sign up'),
      onPressed: () async {
        // validate return true if the form is correct, false if other
        if (_formKey.currentState.validate()) {
          setState(() {
            _loading = true;
          });
          Map<String, dynamic> result =
              await _authenticateController.signUpWithEmailAndPassword(
                  _nameController.text,
                  _emailController.text,
                  _passwordController.text,
                  _passwordConfirmController.text);
          if (result['statusCode'] != 200) {
            setState(() {
              print('Error sign up: ${result['message']}');
              _loading = false;
            });
          } else {
            print('${result['message']} -> sign in screen');
            Navigator.pop(context);
          }
        }
      },
    );

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

    final _signUpForm = Form(
      key: _formKey,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 20),
          _nameField,
          SizedBox(height: 10),
          _emailField,
          SizedBox(height: 10),
          _passwordField,
          SizedBox(height: 10),
          _passwordConfirmField,
          SizedBox(height: 13),
          SizedBox(height: 10),
          _signUpButton,
          _backToSignIn,
        ],
      ),
    );

    final _signUpBody = AppBackGround(
      aboveBackground: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: KeyboardAvoider(
          child: AppCard(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: _signUpForm),
          ),
        ),
      ),
    );

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: _signUpBody,
    );
  }
}
