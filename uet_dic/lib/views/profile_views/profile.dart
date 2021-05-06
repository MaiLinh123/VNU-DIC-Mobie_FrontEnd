import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/models/user_model.dart';
import 'package:uet_dic/share/app_background.dart';
import 'package:uet_dic/share/app_bar.dart';
import 'package:uet_dic/share/app_card.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User currentUser =
        Provider.of<AuthenticateController>(context, listen: false).currentUser;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(
        title: 'Profile',
      ),
      body: AppBackGround(
        aboveBackground: Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: Column(
            children: [
              Icon(
                Icons.account_circle,
                size: 100,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7, bottom: 20),
                child: Text(
                  'Account info',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
              ),
              Expanded(
                child: AppCard(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ListTile(
                        title: Text(
                          'Name',
                        ),
                        subtitle: Text(currentUser.username),
                        leading: Icon(Icons.person),
                      ),
                      ListTile(
                          title: Text(
                            'Mail',
                          ),
                          subtitle: Text(currentUser.email),
                          leading: Icon(Icons.mail)),
                      ListTile(
                        title: Text(
                          'Favourite words',
                        ),
                        subtitle: Text('${currentUser.words.length}'),
                        leading: Icon(Icons.menu_book_outlined),
                        trailing: IconButton(
                          icon: Icon(Icons.arrow_forward_ios_rounded),
                          iconSize: 18,
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/favourite');
                        },
                      ),
                      ListTile(
                        title: Text(
                          'Password',
                        ),
                        leading: Icon(Icons.vpn_key_rounded),
                        trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.pushNamed(context, '/updatepassword');
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
