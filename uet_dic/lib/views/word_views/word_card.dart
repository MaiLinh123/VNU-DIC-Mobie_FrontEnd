import 'package:flutter/material.dart';
import 'package:uet_dic/share/app_card.dart';

import 'word_card_title.dart';

class WordCard extends StatelessWidget {

  @required final Map word;

  const WordCard({this.word});

  @override
  Widget build(BuildContext context) {
    final title = CardTitle(word: this.word,);
    final List<Widget> contents = [];
    for (final _meaning in this.word['meanings']) {
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
            title,
            Divider(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(left: 13, right: 13),
                physics: const BouncingScrollPhysics(),
                children: contents,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
