import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/authenticate_controller.dart';

import 'authenticate_views/authenticate_view.dart';
import 'home_screen.dart';

class ScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('wrapper');
    // return home or authenticate
    return Provider.of<AuthenticateController>(context, listen: true).currentUser == null ? AuthenticateScreen() : HomeScreen();
  }
}
