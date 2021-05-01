import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/share/app_loading.dart';
import 'package:uet_dic/views/authenticate_views/auth_share.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;
  bool _isSignUp = false;


  @override
  Widget build(BuildContext context) {
    if (_loading) return AppLoading();

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

    if(this._isSignUp) {
      print('Sign Up Screen');

      final _nameField = myTextFormField(
        controller: _nameController,
        validator: (value) {
          if (value.isEmpty) return "Please enter your name";
          return null;
        },
        hintText: "Enter name",
        iconData: Icons.account_circle,
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
              this._loading = true;
            });
            Map<String, dynamic> result =
            await _authenticateController.signUpWithEmailAndPassword(
              _nameController.text,
              _emailController.text,
              _passwordController.text,
              _passwordConfirmController.text,
            );
            if (result['statusCode'] != 200) {
              setState(() {
                print('Error sign up: ${result['message']}');
                this._loading = false;
              });
            } else {
              print('${result['message']} -> sign in screen');
              setState(() {
                this._isSignUp = false;
                this._loading = false;
              });
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
              setState(() {
                this._isSignUp = false;
              });
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

      return _signUpForm;
    } else {
      print('Sign In Screen');

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
          setState(() {
            this._isSignUp = true;
          });
        },
      );
      final _signInForm = Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(height: 20),
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

      return _signInForm;
    }
  }
}
