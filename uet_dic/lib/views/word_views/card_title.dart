import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardTitle extends StatefulWidget {
  String title;
  String subTitle;
  bool saved;
  CardTitle({this.title, this.subTitle, this.saved});

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
            ),
            onPressed: () {
              setState(() {
                widget.saved = !widget.saved;
              });
            },
          )
        ],
      ),
      subtitle: Row(
        children: [
          Text('${widget.subTitle}'),
          IconButton(
            icon: Icon(
              Icons.volume_up_rounded,
              color: Colors.green[400],
            ),
            onPressed: () async {
              print('Sound press');

            },
          ),
        ],
      ),
    );
  }
}
