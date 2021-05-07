import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/share/app_loading.dart';
import 'package:uet_dic/share/app_logo.dart';
import 'package:uet_dic/views/authenticate_views/auth_components/auth_button.dart';

import 'auth_components/auth_text_form_field.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    if (_loading) return AppLoading();

    final _authenticateController =
        Provider.of<AuthenticateController>(context, listen: false);

    final _emailField = AuthTextFormField(
      controller: _emailController,
      validator: (value) {
        if (value.isEmpty) return "Please enter your email";
        return null;
      },
      iconData: Icons.email_rounded,
      hintText: "Enter email",
    );
    final _passwordField = AuthTextFormField(
      obscureText: true,
      controller: _passwordController,
      validator: (value) {
        if (value.isEmpty) return "Please enter your password";
        return null;
      },
      iconData: Icons.vpn_key,
      hintText: "Enter password",
    );

    print('Sign In Screen');

    final _signInButton = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AuthButton(
          child: Text('Sign in'),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              setState(() => this._loading = true);
              int statusCode =
                  await _authenticateController.signInWithEmailAndPassword(
                      _emailController.text, _passwordController.text);
              if (statusCode != 200) setState(() => this._loading = false);
            }
          },
        ),
        Text('or'),
        // start now button
        AuthButton(
          child: Text('Start now'),
          onPressed: () async {
            setState(() => this._loading = true);
            int statusCode = await _authenticateController.signInAnonymously();
            if (statusCode != 200) setState(() => this._loading = false);
          },
        ),
      ],
    );
    final _signUpButton = AuthButton(
      child: Text('Create New Account'),
      onPressed: () async {
        final result = await Navigator.pushNamed(context, '/signup');
        if (result != null) _emailController.text = result;
      },
    );

    return Form(
      key: _formKey,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 20),
          AppLogo(),
          SizedBox(height: 50),
          _emailField,
          SizedBox(height: 10),
          _passwordField,
          SizedBox(height: 23),
          _signInButton,
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Divider(color: Colors.grey[800]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: _signUpButton,
          ),
        ],
      ),
    );
  }
}
