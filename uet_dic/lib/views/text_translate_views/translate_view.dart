import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uet_dic/share/app_background.dart';
import 'package:uet_dic/share/app_bar.dart';
import 'package:uet_dic/share/app_card.dart';
import 'package:uet_dic/views/text_translate_views/translate_language.dart';
import 'package:uet_dic/views/text_translate_views/translate_result.dart';
import 'package:uet_dic/views/text_translate_views/translate_search.dart';


class TextTranslate extends StatelessWidget {
  final GlobalKey<TranslateResultState> _translateResultKey = new GlobalKey<TranslateResultState>();
  final GlobalKey<TranslateLanguageState> _translateLanguageKey = new GlobalKey<TranslateLanguageState>();

  @override
  Widget build(BuildContext context) {
    print('Translator Screen');

    final _translateResult = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
        child: Text(
          'Translate result',
          style: TextStyle(fontSize: 16.0, color: Colors.green),
        ),
      ),
      Divider(thickness: 1),
      Expanded(child: TranslateResult(key: _translateResultKey,)),
    ]);

    final _translateLanguage = TranslateLanguage(key: _translateLanguageKey,);
    final _translateSearch = TranslateSearch(translateResultStateKey : _translateResultKey, translateLanguageKey:_translateLanguageKey);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(
        title: 'Translator',
      ),
      body: AppBackGround(
        aboveBackground: Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: Column(
            children: [
              _translateSearch,
              _translateLanguage,
              Expanded(child: AppCard(child: _translateResult),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
