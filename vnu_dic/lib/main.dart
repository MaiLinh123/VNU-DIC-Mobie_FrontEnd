import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vnu_dic/views/wrapper_screen.dart';

import 'controllers/authenticate_controller.dart';

void main() async {
  runApp(UDictApp());
}

class UDictApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthenticateController(),
      child: MaterialApp(
        // wrapper choose Home() or Authenticate()
        home: ScreenWrapper(),
      ),
    );
  }
}