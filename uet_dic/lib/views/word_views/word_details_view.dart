import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:uet_dic/share/app_background.dart';
import 'package:uet_dic/views/word_views/card_contents.dart';

class WordDetailsView extends StatefulWidget {

  final List words;
  WordDetailsView({Key key, @required this.words}) : super(key: key);

  @override
  _WordDetailsViewState createState() => _WordDetailsViewState();
}

class _WordDetailsViewState extends State<WordDetailsView> {

  @override
  Widget build(BuildContext context) {
    final _wordDetailsViewAppbar = AppBar(
      elevation: 5,
      backgroundColor: Colors.white,
      title: Text('Word details', style: TextStyle(color: Colors.green[400]),),
      iconTheme: IconThemeData(
        color: Colors.green[400], //change your color here
      ),
    );

    final _wordCards = Swiper(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return CardContents(widget.words[index]);
      },
      itemCount: widget.words.length,
      viewportFraction: 0.85,
      scale: 0.9,
      loop: false,
    );

    final _wordDetailsViewBody = AppBackGround(
      aboveBackground: Column(
        children: [
          SizedBox(height: 45),
          Expanded(child: _wordCards),
        ],
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _wordDetailsViewAppbar,
      body: _wordDetailsViewBody,
    );
  }
}
