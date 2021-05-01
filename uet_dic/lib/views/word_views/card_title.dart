import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/authenticate_controller.dart';

class CardTitle extends StatefulWidget {
  String wordId;
  String title;
  String subTitle;
  bool saved;
  String audio;

  CardTitle({this.wordId, this.title, this.subTitle, this.saved, this.audio});


  @override
  _CardTitleState createState() => _CardTitleState();
}

class _CardTitleState extends State<CardTitle> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.green[400],
              letterSpacing: 1,
            ),
          ),
          IconButton(
            icon: Icon(
              widget.saved ? Icons.favorite : Icons.favorite_border,
              color: Colors.pink,
              size: 30,
            ),
            onPressed: () {
              if(!widget.saved) Provider.of<AuthenticateController>(context).currentUser.saveWords(widget.wordId);
              setState(() {
                widget.saved = !widget.saved;
              });
            },
          )
        ],
      ),
      subtitle: widget.subTitle != '' ? Row(
        children: [
          Text('${widget.subTitle}'),
          IconButton(
            icon: Icon(
              Icons.volume_up_rounded,
              color: Colors.green[400],
            ),
            onPressed: () async {
              AudioPlayer audioPlayer = AudioPlayer();
              audioPlayer.play(widget.audio);
            },
          ),
        ],
      ) : Row(),
    );
  }
}
