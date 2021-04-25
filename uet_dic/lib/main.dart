import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/views/authenticate_views/sign_in_view.dart';
import 'package:uet_dic/views/authenticate_views/sign_up_view.dart';
import 'package:uet_dic/views/wrapper_screen.dart';
import 'package:uet_dic/views/wrapper_views/profile.dart';
import 'package:uet_dic/views/wrapper_views/setting.dart';

import 'controllers/authenticate_controller.dart';

void main() async {
  runApp(UDictApp());
}

class UDictApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticateController()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => ScreenWrapper(),
          '/signin': (context) => SignInScreen(),
          '/signup': (context) => SignUpScreen(),
          '/setting': (context) => Setting(),
          '/profile': (context) => Profile(),
        },
      ),
    );
  }
}