import 'package:flutter/material.dart';

class TranslateLanguage extends StatefulWidget {
  const TranslateLanguage({Key key}) : super(key: key);

  @override
  TranslateLanguageState createState() => TranslateLanguageState();
}

class TranslateLanguageState extends State<TranslateLanguage> {
  String sl = 'en';
  String tl = 'vi';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Text(this.sl == 'en' ? 'English':'Vietnamese',
            style: TextStyle(color: Colors.white),),
          width: 90,
          alignment: Alignment.center
        ),
        FlatButton(
          child: Icon(Icons.swap_horiz_outlined),
          minWidth: 0,
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              this.sl = this.tl;
              this.tl = this.tl == 'en' ? 'vi' : 'en';
            });
          },
        ),
        Container(
          child: Text(this.tl == 'en' ? 'English':'Vietnamese',
            style: TextStyle(color: Colors.white),),
          width: 90,
          alignment: Alignment.center,
        ),
      ],
    );
  }
}
