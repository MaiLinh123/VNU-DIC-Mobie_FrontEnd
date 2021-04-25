import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/views/home_components//search.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print('Home Screen');

    final _authenticateController = Provider.of<AuthenticateController>(context);
    final _homeDrawer = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Wrapper header
          DrawerHeader(
            child: Text('VNU Dictionary'),
            decoration: BoxDecoration(
              color: Colors.green[400],
            ),
          ),
          // Wrapper title
          ListTile(
            title: Text(
              'Menu',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          // Wrapper home button
          Card(
            child: ListTile(
              leading: Icon(Icons.home),
              title:
                  Text('Home', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            margin: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
          ),
          // Wrapper setting button
          Card(
            child: ListTile(
              title: Text('Setting',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.popAndPushNamed(context, '/setting');
              },
            ),
            margin: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
          ),
          // Wrapper Profile Button
          Card(
            child: ListTile(
              title: Text('Profile',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              leading: Icon(Icons.account_circle),
              onTap: () {
                Navigator.popAndPushNamed(context, '/profile');
              },
            ),
            margin: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
          ),
          Card(
            child: ListTile(
              title: Text('Log Out',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              leading: Icon(Icons.logout),
              onTap: () {
                _authenticateController.signOut();
              },
            ),
            margin: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
          ),
        ],
      ),
    );
    final _homeAppbar = AppBar(
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
    );

    return Scaffold(
      key: _scaffoldKey,
      drawer: _homeDrawer,
      appBar: _homeAppbar,
      body: Search(),
    );
  }
}
