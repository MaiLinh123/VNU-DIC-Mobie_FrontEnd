import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/word_controller.dart';
import 'package:uet_dic/views/word_views/word_details_view.dart';

class HomeRecentWords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordController = Provider.of<WordController>(context, listen: true);

    List<String> encodedWordList = wordController.recentWordsList;
    int length = encodedWordList.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LiveList(
        physics: const BouncingScrollPhysics(),
        showItemInterval: Duration(milliseconds: 25),
        itemCount: length,

        itemBuilder: (context, index, animation) {
          index = length - index - 1;
          final word = json.decode(encodedWordList[index]);
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                  begin: Offset(0, 0.1),
                  end: Offset.zero
              ).animate(animation),
              child: Column(
                children: [
                  ListTile(
                    visualDensity: VisualDensity(vertical: -4),
                    contentPadding: EdgeInsets.zero,
                    leading: IconButton(
                      icon: Icon(
                        Icons.history,
                        color: Colors.green[400],
                      ),
                      onPressed: () async {
                        final result = await wordController.queryWord(word['word']);
                        if (result['statusCode'] == 200) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WordDetailsView(wordsList: result['queriedWordsList']),
                            ),
                          );
                        }
                      },
                    ),
                    title: Text(
                      word['word'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    subtitle: Text('${word['phonetic']}'),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.volume_up_rounded,
                        color: Colors.green[400],
                      ),
                      onPressed: () async {
                        AudioPlayer audioPlayer = AudioPlayer();
                        audioPlayer.play(word['audio']);
                      },
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
