import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/share/app_loading.dart';
import 'package:uet_dic/share/app_logo.dart';
import 'package:uet_dic/views/authenticate_views/auth_components/auth_button.dart';
import 'auth_components/auth_text_form_field.dart';

class ChangePasswordForm extends StatefulWidget {
  @override
  _ChangePasswordForm createState() => _ChangePasswordForm();
}

class _ChangePasswordForm extends State<ChangePasswordForm> {
  final _oldPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;


  @override
  Widget build(BuildContext context) {
    if (_loading) return AppLoading();
    print('Change pass word Screen');
    final _authenticateController =
      Provider.of<AuthenticateController>(context, listen: false);

    final _oldPasswordField = AuthTextFormField(
      obscureText: true,
      controller: _oldPasswordController,
      validator: (value) {
        if (value.isEmpty) return "Please enter your old password";
        return null;
      },
      iconData: Icons.vpn_key_rounded,
      hintText: "Enter old password",
    );
    final _passwordField = AuthTextFormField(
      obscureText: true,
      controller: _passwordController,
      validator: (value) {
        if (value.isEmpty) return "Please enter your password";
        return null;
      },
      iconData: Icons.vpn_key_rounded,
      hintText: "Enter password",
    );

    final _passwordConfirmField = AuthTextFormField(
      obscureText: true,
      controller: _passwordConfirmController,
      validator: (value) {
        if (value != _passwordController.text)
          return 'Confirm password incorrect';
        return null;
      },
      iconData: Icons.vpn_key_rounded,
      hintText: "Confirm your password",
    );
    final _changePassButton = AuthButton(
      child: Text('Update password'),
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          setState(() {
            this._loading = true;
          });
          int statusCode = await _authenticateController.currentUser.updatePassword(
            _oldPasswordController.text,
            _passwordController.text,
            _passwordConfirmController.text
          );
          if (statusCode == 200) {
            Navigator.popUntil(context, ModalRoute.withName('/'));
            await _authenticateController.signOut();
            showToast('Sign in again', 200);
          }
          else {
            setState(() {
              this._loading = false;
            });
          }
        }
      },
    );

    return Form(
      key: _formKey,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 40),
          _oldPasswordField,
          SizedBox(height: 10),
          _passwordField,
          SizedBox(height: 10),
          _passwordConfirmField,
          SizedBox(height: 23),
          _changePassButton,
        ],
      ),
    );
  }
}
