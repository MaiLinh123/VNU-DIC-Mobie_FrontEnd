import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:uet_dic/share/app_background.dart';
import 'package:uet_dic/share/app_bar.dart';
import 'package:uet_dic/views/word_views/word_card_content.dart';

class WordDetailsView extends StatelessWidget {

  @required final List words;
  WordDetailsView({this.words});

  @override
  Widget build(BuildContext context) {
    print('Word details view');

    final _wordCards = Swiper(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return WordCardContent(word: this.words[index]);
      },
      itemCount: this.words.length,
      viewportFraction: 0.85,
      scale: 0.9,
      loop: false,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(title: 'Word details'),
      body: AppBackGround(
        aboveBackground: Column(
          children: [
            SizedBox(height: 40),
            Expanded(child: _wordCards),
          ],
        ),
      ),
    );
  }
}
