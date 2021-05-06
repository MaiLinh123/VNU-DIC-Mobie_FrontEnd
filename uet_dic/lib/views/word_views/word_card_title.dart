import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/models/user_model.dart';

class CardTitle extends StatefulWidget {
  @required final Map<String, dynamic> word;

  const CardTitle({this.word});


  @override
  _CardTitleState createState() => _CardTitleState();
}

class _CardTitleState extends State<CardTitle> {
  bool saved;

  @override
  Widget build(BuildContext context) {
    final User currentUser = Provider.of<AuthenticateController>(context, listen: false).currentUser;
    this.saved = currentUser.checkExistWord(widget.word['_id']);
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.word['word'],
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.green[400],
              letterSpacing: 1,
            ),
          ),
          IconButton(
            icon: Icon(
              this.saved ? Icons.favorite : Icons.favorite_border,
              color: Colors.pink,
              size: 30,
            ),
            onPressed: () async {
              if(!this.saved) await currentUser.favouriteWord(widget.word);
              else await currentUser.unFavouriteWord(widget.word['_id']);
              setState(() => {});
            },
          )
        ],
      ),
      subtitle: widget.word['phonetics'].isNotEmpty ? Row(
        children: [
          Text('${widget.word['phonetics'][0]['text']}'),
          IconButton(
            icon: Icon(
              Icons.volume_up_rounded,
              color: Colors.green[400],
            ),
            onPressed: () async {
              AudioPlayer audioPlayer = AudioPlayer();
              audioPlayer.play(widget.word['phonetics'][0]['text']);
            },
          ),
        ],
      ) : Row(),
    );
  }
}
