import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/word_controller.dart';

class HomeHistoryWords extends StatefulWidget {
  @override
  _HomeHistoryWordsState createState() => _HomeHistoryWordsState();
}

class _HomeHistoryWordsState extends State<HomeHistoryWords> {
  @override
  Widget build(BuildContext context) {
    final _wordController = Provider.of<WordController>(context, listen: true);
    List<Widget> recentWord = [];
    int i = 0;
    for(String word in _wordController.recentWord.reversed) {
      i = i + 1;
      recentWord.add(ListTile(
        title: Text('$i $word',
            style: TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text('$word'),
      ));
    }
    return ListView(
            physics: const BouncingScrollPhysics(),
            children: recentWord,
          );
  }
}
