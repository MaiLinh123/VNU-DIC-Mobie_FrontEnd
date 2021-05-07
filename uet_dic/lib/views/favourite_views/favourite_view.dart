import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/models/user_model.dart';
import 'package:uet_dic/models/word_model.dart';
import 'package:uet_dic/share/app_background.dart';
import 'package:uet_dic/share/app_bar.dart';
import 'package:uet_dic/share/app_card.dart';
import 'package:uet_dic/views/favourite_views/favourite_item.dart';
import 'package:auto_animated/auto_animated.dart';

class FavouriteView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _appBar = MyAppBar(title: 'Favourite');

    final User _currentUser =  Provider.of<AuthenticateController>(context, listen: false).currentUser;

    return FutureBuilder<List<Word>>(

      initialData: [],

      future: _currentUser.getFavouriteListByID(),

      builder: (context, AsyncSnapshot snap) {

        final List<Word> favouriteList = snap.data;

        final favouriteWordListTitle = LiveList(
          showItemInterval: Duration(milliseconds: 25),
          physics: const BouncingScrollPhysics(),
          itemCount: favouriteList.length,
          itemBuilder: (context, index, animation) {
            Word word = favouriteList[index];
            return Column(
              children: [
                FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0, 0.1),
                      end: Offset.zero
                    ).animate(animation),
                    child: FavouriteItem(word: word),
                  ),
                ),
                Divider(),
              ],
            );
          },
        );

        final _favouriteViewBody = AppBackGround(
          aboveBackground: Padding(
            padding: const EdgeInsets.fromLTRB(30, 25, 30, 0),
            child: AppCard(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: favouriteWordListTitle,
              ),
            ),
          ),
        );

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: _appBar,
          body: _favouriteViewBody,
        );
      },
    );
  }
}