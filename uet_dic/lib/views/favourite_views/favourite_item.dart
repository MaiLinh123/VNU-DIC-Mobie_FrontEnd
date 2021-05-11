import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/models/user_model.dart';
import 'package:uet_dic/models/word_model.dart';
import 'package:uet_dic/views/word_views/word_details_view.dart';

class FavouriteItem extends StatefulWidget {

  final Word word;

  const FavouriteItem({this.word});

  @override
  _FavouriteItemState createState() => _FavouriteItemState();
}

class _FavouriteItemState extends State<FavouriteItem> {
  @override
  Widget build(BuildContext context) {

    final User currentUser =  Provider.of<AuthenticateController>(context, listen: false).currentUser;
    bool saved = currentUser.checkExistWord(widget.word.id);

    return ListTile(
      visualDensity: VisualDensity(vertical: -4),
      contentPadding: EdgeInsets.zero,

      leading: IconButton(
        icon: Icon(
          saved ? Icons.favorite : Icons.favorite_outline,
          color: Colors.pink[400],
        ),
        onPressed: () async {
          final result = saved ?
            await currentUser.unFavouriteWord(widget.word.id) :
            await currentUser.favouriteWord(widget.word);
          if(result == 200) setState(() {});
        },
      ),

      title: Text(
        widget.word.word,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green[700],
          fontSize: 18,
        ),
      ),

      subtitle: Text('${widget.word.phonetic.text}'),

      trailing: IconButton(
        icon: Icon(
          Icons.volume_up_rounded,
          color: Colors.green[400],
        ),
        onPressed: () async {
          AudioPlayer audioPlayer = AudioPlayer();
          await audioPlayer.play('${widget.word.phonetic.audio}');
        },
      ),

      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WordDetailsView(wordsList: [widget.word]),
          ),
        );
      },
    );
  }
}
