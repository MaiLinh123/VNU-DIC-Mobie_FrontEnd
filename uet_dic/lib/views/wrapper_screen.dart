import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/views/authenticate_views/auth_view.dart';

import 'home_screen.dart';

class ScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('wrapper');
    final _authenticateController =  Provider.of<AuthenticateController>(context, listen: true);
    if(_authenticateController.currentUser == null) _authenticateController.signInWithToken();
    // return home or authenticate
    return _authenticateController.currentUser == null ? AuthenticateView() : HomeScreen();
  }
}
