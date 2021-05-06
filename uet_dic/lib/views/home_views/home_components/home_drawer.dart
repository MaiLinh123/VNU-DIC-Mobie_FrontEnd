import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/authenticate_controller.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authenticateController =
        Provider.of<AuthenticateController>(context, listen: false);

    final _drawerHeader = DrawerHeader(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.auto_stories,
            size: 80,
            color: Colors.green,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'VNU',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[400],
                    fontSize: 40),
              ),
              Text(
                'Dictionary',
                style: TextStyle(color: Colors.green[400], fontSize: 30),
              )
            ],
          ),
        ],
      ),
    );
    final _drawerUser = ListTile(
      title: Text(
        _authenticateController.currentUser.username,
        style: TextStyle(
            color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(_authenticateController.currentUser.email),
      leading: Icon(Icons.person,),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18,),
      onTap: () {
        Navigator.popAndPushNamed(context, '/profile');
      },
    );
    final _drawerHome = ListTile(
      leading: Icon(
        Icons.home,
      ),
      title: Text('Home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
    final _drawerFavourite = ListTile(
      title: Text('Favourite', style: TextStyle(fontWeight: FontWeight.bold)),
      leading: Icon(Icons.favorite),
      onTap: () {
        Navigator.popAndPushNamed(context, '/favourite');
      },
    );
    final _drawerTranslate = ListTile(
      title: Text('Translate', style: TextStyle(fontWeight: FontWeight.bold)),
      leading: Icon(Icons.translate),
      onTap: () {
        Navigator.popAndPushNamed(context, '/translate');
      },
    );
    final _drawerLogout = ListTile(
      title: Text('Log Out', style: TextStyle(fontWeight: FontWeight.bold)),
      leading: Icon(Icons.logout),
      onTap: () {
        _authenticateController.signOut();
      },
    );

    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _drawerHeader,
            _drawerUser,
            _drawerHome,
            _drawerFavourite,
            _drawerTranslate,
            _drawerLogout
          ],
        ),
      ),
    );
  }
}
