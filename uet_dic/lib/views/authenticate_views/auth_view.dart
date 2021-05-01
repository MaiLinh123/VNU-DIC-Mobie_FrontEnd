import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:uet_dic/share/app_card.dart';
import 'package:uet_dic/share/app_background.dart';
import 'package:uet_dic/views/authenticate_views/sign_in_form.dart';
import 'package:uet_dic/views/authenticate_views/sign_up_form.dart';

class AuthenticateView extends StatelessWidget {
  bool _isSignUp;

  AuthenticateView({bool isSignUp = false}) {
    this._isSignUp = isSignUp;
  }

  @override
  Widget build(BuildContext context) {
    final _authenticateViewBody = AppBackGround(
      aboveBackground: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: KeyboardAvoider(
          child: AppCard(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: _isSignUp ? SignUpForm() : SignInForm(),
            ),
          ),
        ),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: _authenticateViewBody,
    );
  }
}
