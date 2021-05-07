import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/word_controller.dart';
import 'package:uet_dic/share/app_bar.dart';
import 'package:uet_dic/views/authenticate_views/auth_view.dart';
import 'package:uet_dic/views/authenticate_views/change_pass_form.dart';
import 'package:uet_dic/views/authenticate_views/sign_up_form.dart';
import 'package:uet_dic/views/favourite_views/favourite_view.dart';
import 'package:uet_dic/views/profile_views/profile.dart';
import 'package:uet_dic/views/quizz_views/quiz_view.dart';
import 'package:uet_dic/views/text_translate_views/translate_view.dart';
import 'package:uet_dic/views/wrapper_screen.dart';

import 'controllers/authenticate_controller.dart';

void main() async {
  runApp(UDictApp());
}

class UDictApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Welcome');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticateController()),
        ChangeNotifierProvider(create: (_) => WordController())
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => ScreenWrapper(),
          '/favourite': (context) => FavouriteView(),
          '/profile': (context) => Profile(),
          '/translate': (context) => TextTranslate(),
          '/signup': (context) => AuthenticateView(child: SignUpForm(), loading: false,),
          '/updatepassword': (context) => AuthenticateView(appBar: MyAppBar(title: 'Update password'),child: ChangePasswordForm(), loading: false, ),
          '/quiz': (context) => QuizView(appBar: MyAppBar(title: 'Quizzes')),
        },
      ),
    );
  }
}