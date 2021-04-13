// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:uet_dic/controllers/authenticate_controller.dart';
//
// class HomeScreen extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     print('HomeScreen');
//     final _authenticateController = Provider.of<AuthenticateController>(context);
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         title: Text('Home'),
//         // actions on the right of the appBar
//         actions: [
//           // sign out button
//           ElevatedButton.icon(
//             onPressed: () {
//               _authenticateController.signOut();
//               print('sign out');
//             },
//             icon: Icon(Icons.person),
//             label: Text('Sign out'),
//           ),
//         ],
//       ),
//       body: Center(
//         child: Text('Home'),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/views/search.dart';

// class HomeScreen extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     print('HomeScreen');
//     final _authenticateController = Provider.of<AuthenticateController>(
//         context);
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         title: Text('Home'),
//         // actions on the right of the appBar
//         actions: [
//           // sign out button
//           ElevatedButton.icon(
//             onPressed: () {
//               _authenticateController.signOut();
//               print('sign out');
//             },
//             icon: Icon(Icons.person),
//             label: Text('Sign out'),
//           ),
//         ],
//       ),
//       body: Center(
//         child: MaterialApp(
//             theme: ThemeData(primarySwatch: Colors.blue),
//             home: SearchAppBar()),
//       ),
//     );
//   }
// }
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final _authenticateController = Provider.of<AuthenticateController>(
        context);
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black87,

          ),

          onPressed: () {
            _authenticateController.signOut();
          },
        ),

      ),
      body: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.blue), home:Search()
      ),

    );
  }
}