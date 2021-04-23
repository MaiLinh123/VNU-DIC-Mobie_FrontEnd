import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/views/home_views/search.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final _authenticateController = Provider.of<AuthenticateController>(
        context);
    return Scaffold(
        key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('VNU Dictionary'),
              decoration: BoxDecoration(
                color: Colors.green[400],
              ),
            ),
            ListTile(
              title: Text('Menu', style: TextStyle(color: Colors.green,fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('Home', style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  // some thinghere
                },
              ),
              margin: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
            ),
            Card(
              child: ListTile(
                title: Text('Setting', style: TextStyle(fontWeight: FontWeight.bold)),
                leading: Icon(Icons.settings),
                onTap: () {
                  // some thinghere
                },
              ),
              margin: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
            ),
            Card(
              child: ListTile(
                title: Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
                leading: Icon(Icons.account_circle),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              margin: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
            ),
            ListTile(
              title: Text('Log Out', style: TextStyle(fontWeight: FontWeight.bold)),
              leading: Icon(Icons.logout),
              onTap: () {
                _authenticateController.signOut();
                print('sign out');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.green[400],
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: 25,

          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        title: Text('Home'),
      ),
      /*body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Text(
                      //   'VNU-DIC',
                      //   style: TextStyle(color: Colors.blue, fontSize: 35, fontWeight: FontWeight.bold),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),

                      *//*Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(244, 243, 243,1),
                            borderRadius: BorderRadius.circular(25)),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black87,
                              ),
                              suffixIcon: IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.mic, color: Colors.black87),
                              ),
                              hintText: "Tra cứu từ điển Anh - Việt",
                              hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 15)),
                        ),
                      ),*//*
                    ],
                  ),
                ),
                *//*ElevatedButton(
                child: Text('EXPLORE'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[400],//background
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0)),
                  padding: EdgeInsets.all(15.0),
                ), onPressed: () { },
              ),*//*
              ],
            ),
          ),
        ),*/
      body: Search(),
    );
  }
}