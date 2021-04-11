import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vnu_dic/controllers/authenticate_controller.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('HomeScreen');
    final _authenticateController = Provider.of<AuthenticateController>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Home'),
        // actions on the right of the appBar
        actions: [
          // sign out button
          ElevatedButton.icon(
            onPressed: () {
              _authenticateController.signOut();
              print('sign out');
            },
            icon: Icon(Icons.person),
            label: Text('Sign out'),
          ),
        ],
      ),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
