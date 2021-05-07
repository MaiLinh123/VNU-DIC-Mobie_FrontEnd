import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/views/authenticate_views/auth_view.dart';
import 'package:uet_dic/views/authenticate_views/sign_in_form.dart';

import 'home_views/home_screen.dart';

class ScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    print('wrapper');
    /// this will listen to the change of user
    final _authenticateController = Provider.of<AuthenticateController>(context, listen: true);
    /// check current user
    /// if user == null then try resign in by token
    /// if token not found then navigator to sign in screen
    if (_authenticateController.currentUser == null) {
      return FutureBuilder<int>(
          /// check token
          future: _authenticateController.signInWithToken(),
          builder: (BuildContext context, AsyncSnapshot snap) {
            return AuthenticateView(
              loading: snap.data == null,
              child: SignInForm(),
            );
          });
    }
    /// if sign in with token success then navigator to home screen
    return HomeScreen();
  }
}
