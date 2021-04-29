import 'package:flutter/material.dart';
import 'package:uet_dic/share/app_background.dart';
import 'package:uet_dic/share/app_card.dart';
import 'package:uet_dic/views/home_components/home_drawer.dart';
import 'package:uet_dic/views/home_components/home_history_words.dart';
import 'package:uet_dic/views/home_components/home_search.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print('Home Screen');

    final _homeAppbar = AppBar(
      brightness: Brightness.light,
      elevation: 5,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          size: 25,
          color: Colors.green[400],
        ),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      title: Text(
        'Home',
        style: TextStyle(color: Colors.green[400]),
      ),
    );
    final _homeDrawer = HomeDrawer();
    final _homeSearch = HomeSearch();
    final _homeWordList =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
        child: Text(
          'Recent Words',
          style: TextStyle(fontSize: 14.0, color: Colors.green),
        ),
      ),
      Divider(thickness: 1),
      Expanded(child: HomeHistoryWords()),
    ]);
    final _homeBody = AppBackGround(
      aboveBackground: Padding(
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
        child: Column(
          children: [
            _homeSearch,
            SizedBox(height: 50),
            Expanded(child: AppCard(child: _homeWordList)),
          ],
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: _homeDrawer,
      appBar: _homeAppbar,
      body: _homeBody,
    );
  }
}
