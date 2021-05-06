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
    final _authenticateController =  Provider.of<AuthenticateController>(context, listen: true);
    if(_authenticateController.currentUser == null) {
      return FutureBuilder<Map<String, dynamic>>(
          future: _authenticateController.signInWithToken(),
          builder: (BuildContext context, AsyncSnapshot snap) {
            return AuthenticateView(loading: snap.data == null, child: SignInForm(),);
          }
      );
    }
    return HomeScreen();
  }
}
