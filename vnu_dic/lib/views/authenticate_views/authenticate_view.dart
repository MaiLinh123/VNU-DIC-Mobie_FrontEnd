import 'package:flutter/material.dart';
import 'package:vnu_dic/views/authenticate_views/sign_in_view.dart';
import 'package:vnu_dic/views/authenticate_views/sign_up_view.dart';

class AuthenticateScreen extends StatefulWidget {
  @override
  _AuthenticateScreenState createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  bool _showSignIn = true;

  void toggleView() {
    setState(() {
      _showSignIn = !_showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showSignIn ? SignInScreen(toggleView: toggleView) : SignUpScreen(toggleView: toggleView);
  }
}
