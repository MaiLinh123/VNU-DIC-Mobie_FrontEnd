import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/share/app_loading.dart';
import 'package:uet_dic/share/app_logo.dart';
import 'package:uet_dic/views/authenticate_views/auth_components/auth_button.dart';
import 'auth_components/auth_text_form_field.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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

    final _nameField = AuthTextFormField(
      controller: _nameController,
      validator: (value) {
        if (value.isEmpty) return "Please enter your name";
        return null;
      },
      hintText: "Enter name",
      iconData: Icons.account_circle,
    );
    final _passwordConfirmField = AuthTextFormField(
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
    final _signUpButton = AuthButton(
      child: Text('Sign up'),
      onPressed: () async {
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
          if (result['statusCode'] == 200) Navigator.pop(context, _emailController.text);
          setState(() {
            this._loading = false;
          });
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

    return Form(
      key: _formKey,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 10),
          AppLogo(),
          SizedBox(height: 40),
          _nameField,
          SizedBox(height: 10),
          _emailField,
          SizedBox(height: 10),
          _passwordField,
          SizedBox(height: 10),
          _passwordConfirmField,
          SizedBox(height: 23),
          _signUpButton,
          _backToSignIn,
        ],
      ),
    );
  }
}
