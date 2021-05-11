import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:uet_dic/share/app_card.dart';
import 'package:uet_dic/share/app_background.dart';
import 'package:uet_dic/share/app_loading.dart';

class AuthenticateView extends StatelessWidget {

  @required final bool loading;
  @required final Widget child;
  final Widget appBar;
  const AuthenticateView({this.loading = false, this.child, this.appBar});

  @override
  Widget build(BuildContext context) {

    final _authenticateViewBody = AppBackGround(
      aboveBackground: Padding(
        padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
        child: AppCard(
          child: this.loading ? AppLoading() :
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: KeyboardAvoider(child: this.child)
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: this.appBar,
      resizeToAvoidBottomInset: false,
      body: _authenticateViewBody,
    );
  }
}
