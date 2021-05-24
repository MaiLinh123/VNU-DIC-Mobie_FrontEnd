import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/share/app_background.dart';
import 'package:uet_dic/share/app_bar.dart';
import 'package:uet_dic/share/app_card.dart';
import 'package:uet_dic/share/app_loading.dart';

import 'home_components/home_button.dart';
import 'home_components/home_drawer.dart';
import 'home_components/home_recent_words.dart';
import 'home_components/home_search.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print('Home Screen');
    final _authenticateController =
      Provider.of<AuthenticateController>(context, listen: false);

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
          onPress: () {
            if(_authenticateController.currentUser.wordIdMap.length < 6) {
              showToast('Favourite words list must have at least 6 words', 400);
            }
            else Navigator.pushNamed(context, '/quiz');
          },
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
        padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
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
