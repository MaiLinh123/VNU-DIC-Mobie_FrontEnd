import 'package:flutter/material.dart';
import 'package:uet_dic/models/quiz_model.dart';

class QuizButton extends StatelessWidget {
  final Answer answer;
  final bool isChosen;
  final bool isCorrect;
  QuizButton({this.answer, this.isChosen, this.isCorrect});

  @override
  Widget build(BuildContext context) {
    Color wordColor = Colors.green[400];
    Color phoneticColor = Colors.grey;
    Color backgroundColor;
    Border border = Border.all(color: Colors.green[400], width: 2);
    if(this.isCorrect == null) {
      if(this.isChosen) {
        wordColor = Colors.white;
        phoneticColor = Colors.white;
        backgroundColor = Colors.yellow[700];
        border = null;
      }
    } else if(this.isCorrect) {
      wordColor = Colors.white;
      phoneticColor = Colors.white;
      backgroundColor = Colors.green[400];
      border = null;
    } else if(this.isChosen) {
      wordColor = Colors.white;
      phoneticColor = Colors.white;
      backgroundColor = Colors.red[400];
      border = null;
    }
    return Container(
        alignment: Alignment.center,
        width: 130,
        height: 60,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              this.answer.word,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: wordColor),
            ),
            Text(
              this.answer.phonetic.text,
              style: TextStyle(fontSize: 13, color: phoneticColor) ,
            ),
          ],
        ),
    );
  }
}
