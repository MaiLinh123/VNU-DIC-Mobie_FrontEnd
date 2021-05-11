import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uet_dic/models/quiz_model.dart';
import 'package:uet_dic/share/app_card.dart';
import 'package:uet_dic/share/app_loading.dart';
import 'package:uet_dic/views/quiz_views/quiz_button.dart';

class QuizCard extends StatefulWidget {
  QuizCard({this.quiz});

  final Quiz quiz;

  @override
  _QuizCardState createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  @override
  Widget build(BuildContext context) {
    List<Widget> quizButtons = [];
    for (var i = 0; i < 4; i++) {
      quizButtons.add(
        InkWell(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: QuizButton(
            answer: widget.quiz.allAnswer[i],
            isChosen: widget.quiz.chosen == i,
            isCorrect: widget.quiz.isCheck ? widget.quiz.correct == i : null,
          ),
          onTap: () {
            if(!widget.quiz.isCheck) {
              setState(() {
                widget.quiz.chosen = i;
              });
            }
          },
        ),
      );
    }
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ListTile(
              title: Text(widget.quiz.question),
              subtitle: Text(widget.quiz.partOfSpeech),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    quizButtons[0],
                    quizButtons[1],
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    quizButtons[2],
                    quizButtons[3],
                  ],
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  child: Text('check'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(250, 40),
                    primary: Colors.green[400], //background
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  onPressed: () {
                    if(!widget.quiz.isCheck) {
                      setState(() => widget.quiz.check());
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
