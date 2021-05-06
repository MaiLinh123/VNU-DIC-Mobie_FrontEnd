import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/models/user_model.dart';
import 'package:uet_dic/views/word_views/word_details_view.dart';

class FavouriteItem extends StatefulWidget {

  final Map<String,dynamic> word;
  final String wordID;

  const FavouriteItem({this.word, this.wordID});

  @override
  _FavouriteItemState createState() => _FavouriteItemState();
}

class _FavouriteItemState extends State<FavouriteItem> {
  @override
  Widget build(BuildContext context) {
    final User _currentUser =  Provider.of<AuthenticateController>(context, listen: false).currentUser;
    bool saved = _currentUser.checkExistWord(widget.wordID);
    Map phonetics = widget.word['phonetics'].isEmpty ? {'text':'', 'audio':''} : widget.word['phonetics'][0];
    return ListTile(
      visualDensity: VisualDensity(vertical: -4),
      contentPadding: EdgeInsets.zero,
      leading: IconButton(
        icon: Icon(
          saved ? Icons.favorite : Icons.favorite_outline,
          color: Colors.pink[400],
        ),
        onPressed: () async {
          final result = saved ? await _currentUser.unFavouriteWord(widget.wordID) : await _currentUser.favouriteWord(widget.word);
          if(result == 200) setState(() {});
        },
      ),
      title: Text(
        widget.word['word'],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green[700],
          fontSize: 18,
        ),
      ),
      subtitle: Text('${phonetics['text']}'),
      trailing: IconButton(
        icon: Icon(
          Icons.volume_up_rounded,
          color: Colors.green[400],
        ),
        onPressed: () async {
          AudioPlayer audioPlayer = AudioPlayer();
          await audioPlayer.play('${phonetics['audio']}');
        },
      ),
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WordDetailsView(words: [widget.word]),
          ),
        );
      },
    );
  }
}
