import 'package:uet_dic/models/word_model.dart';

class Quiz {
  String partOfSpeech;
  String question;
  Answer trueAnswer;
  List<Answer> allAnswer = [];

  int chosen = -1;
  int correct = -1;

  bool isCheck = false;

  Quiz({this.partOfSpeech, this.question, this.trueAnswer});

  void check() {
    for (var i = 0; i < 4; i++) {
      if (this.trueAnswer.id == allAnswer[i].id) {
        correct = i;
        isCheck = true;
        break;
      }
    }
  }
}

class Answer {
  String id;
  String word;
  Phonetic phonetic;

  Answer({this.id, this.word, this.phonetic});
}
