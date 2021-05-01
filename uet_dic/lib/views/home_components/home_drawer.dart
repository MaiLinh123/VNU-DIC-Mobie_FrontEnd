import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/authenticate_controller.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authenticateController =
        Provider.of<AuthenticateController>(context);

    final _drawerHeader = DrawerHeader(
      child: Text('VNU Dictionary'),
      decoration: BoxDecoration(
        color: Colors.green[400],
      ),
    );
    final _drawerListTitle = ListTile(
      title: Text(
        'Menu',
        style: TextStyle(
            color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
    final _drawerHomeCard = Card(
      child: ListTile(
        leading: Icon(Icons.home),
        title: Text('Home', style: TextStyle(fontWeight: FontWeight.bold)),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
    );
    final _drawerSettingCard = Card(
      child: ListTile(
        title: Text('Setting', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: Icon(Icons.settings),
        onTap: () {
          Navigator.popAndPushNamed(context, '/setting');
        },
      ),
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
    );
    final _drawerProfileCard = Card(
      child: ListTile(
        title: Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: Icon(Icons.account_circle),
        onTap: () {
          Navigator.popAndPushNamed(context, '/profile');
        },
      ),
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
    );
    final _drawerLogoutCard = Card(
      child: ListTile(
        title: Text('Log Out', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: Icon(Icons.logout),
        onTap: () {
          _authenticateController.signOut();
        },
      ),
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
    );

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _drawerHeader,
          _drawerListTitle,
          _drawerHomeCard,
          _drawerSettingCard,
          _drawerProfileCard,
          _drawerLogoutCard
        ],
      ),
    );
  }
}
