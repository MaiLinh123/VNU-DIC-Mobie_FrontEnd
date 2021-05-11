import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/share/app_loading.dart';
import 'package:uet_dic/share/app_logo.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authenticateController =
        Provider.of<AuthenticateController>(context, listen: false);

    final _drawerHeader = DrawerHeader(child: AppLogo());
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
      onTap: () => Navigator.popAndPushNamed(context, '/favourite'),
    );
    final _drawerQuiz = ListTile(
      title: Text('Quizzes', style: TextStyle(fontWeight: FontWeight.bold)),
      leading: Icon(Icons.star),
      onTap: () {
        if(_authenticateController.currentUser.wordIdMap.length < 6) {
          showToast('Favourite words list must have at least 6 words', 400);
        }
        else Navigator.popAndPushNamed(context, '/quiz');
      },
    );
    final _drawerTranslate = ListTile(
      title: Text('Translate', style: TextStyle(fontWeight: FontWeight.bold)),
      leading: Icon(Icons.g_translate),
      onTap: () => Navigator.popAndPushNamed(context, '/translate'),
    );
    final _drawerLogout = ListTile(
      title: Text('Log Out', style: TextStyle(fontWeight: FontWeight.bold)),
      leading: Icon(Icons.logout),
      onTap: () async {
        await _authenticateController.signOut();
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
            _drawerQuiz,
            _drawerTranslate,
            _drawerLogout
          ],
        ),
      ),
    );
  }
}
