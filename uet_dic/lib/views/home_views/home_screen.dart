import 'package:flutter/material.dart';
import 'package:uet_dic/share/app_background.dart';
import 'package:uet_dic/share/app_bar.dart';
import 'package:uet_dic/share/app_card.dart';

import 'home_components/home_button.dart';
import 'home_components/home_drawer.dart';
import 'home_components/home_recent_words.dart';
import 'home_components/home_search.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print('Home Screen');

    final homeAppbar = MyAppBar(
      title: 'VNU Dictionary',
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          size: 25,
          color: Colors.green[400],
        ),
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
      ),
    );

    final homeDrawer = HomeDrawer();

    final homeSearch = HomeSearch();

    final homeButtonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        HomeButton(
          icon: Icons.favorite_border_rounded,
          label: 'Favourite',
          onPress: () => Navigator.pushNamed(context, '/favourite'),
        ),
        HomeButton(
          icon: Icons.g_translate,
          label: 'Translate',
          onPress: () => Navigator.pushNamed(context, '/translate'),
        ),
        HomeButton(
          icon: Icons.star_border,
          label: 'Quizzes',
          onPress: () => Navigator.pushNamed(context, '/quiz'),
        ),
      ],
    );

    final homeRecentWordList = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
          child: Text(
            'Recent Words',
            style: TextStyle(fontSize: 14.0, color: Colors.green),
          ),
        ),
        Divider(thickness: 1),
        Expanded(child: HomeRecentWords()),
      ],
    );

    final homeBody = AppBackGround(
      aboveBackground: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Column(
          children: [
            homeSearch,
            homeButtonSection,
            Expanded(child: AppCard(child: homeRecentWordList)),
          ],
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: homeDrawer,
      appBar: homeAppbar,
      body: homeBody,
    );
  }
}
