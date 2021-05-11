import 'package:flutter/material.dart';
import 'package:uet_dic/models/word_model.dart';
import 'package:uet_dic/share/app_card.dart';

import 'word_card_title.dart';

class WordCardContent extends StatelessWidget {
  @required
  final Word word;

  const WordCardContent({this.word});

  @override
  Widget build(BuildContext context) {

    final title = CardTitle(word: this.word);
    final List<Widget> contents = [];

    for (final meaning in this.word.meanings) {

      contents.add(
        Text(
          'Mean (${meaning.partOfSpeech})',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green[400],
          ),
        ),
      );

      contents.add(Text('  - ${meaning.definition}\n'));

      if (meaning.example != null) {
        contents.add(
          Text(
            'Example',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green[400],
            ),
          ),
        );
        contents.add(
          Text('  - ${meaning.example}\n'),
        );
      }

      if (meaning.synonyms != null) {
        contents.add(
          Text(
            'Synonyms',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green[400],
            ),
          ),
        );
        contents.add(Text('  - ${meaning.synonyms}\n'));
      }
      contents.add(Divider());
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
