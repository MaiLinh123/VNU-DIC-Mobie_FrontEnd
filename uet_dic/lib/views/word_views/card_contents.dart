import 'package:flutter/material.dart';
import 'package:uet_dic/share/app_card.dart';

import 'card_title.dart';

class CardContents extends StatelessWidget {
  Map _word;
  bool _save;

  CardContents(Map word) {
    this._word = word;
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> contents = [];
    final wordTitle = CardTitle(
        wordId: this._word['word'],
        title: this._word['word'],
        subTitle: this._word['phonetics'].isNotEmpty ? this._word['phonetics'][0]['text'] : '',
        saved: false,
        audio: this._word['phonetics'].isNotEmpty ? this._word['phonetics'][0]['audio'] : '',
    );

    for (final _meaning in this._word['meanings']) {
      for (final _definition in _meaning['definitions']) {
        contents.add(Text('Mean (${_meaning['partOfSpeech']})',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green[400])));
        contents.add(Text('  - ${_definition['definition']}\n'));
        if (_definition['example'] != null) {
          contents.add(Text('Example',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[400])));
          contents.add(Text('  - ${_definition['example']}\n'));
        }
        if (_definition['synonyms'] != null) {
          contents.add(Text('Synonyms',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[400])));
          contents.add(Text('  - ${_definition['synonyms'].join(',  ')}\n'));
        }
        contents.add(Divider());
      }
    }

    return AppCard(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
      child: Column(
        children: [
          wordTitle,
          Divider(),
          Expanded(
            child: ListView(
                padding: EdgeInsets.only(left: 13, right: 13),
                physics: const BouncingScrollPhysics(),
                children: contents),
          ),
        ],
      ),
    ));
  }
}
