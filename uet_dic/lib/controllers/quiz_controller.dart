import 'package:uet_dic/models/quiz_model.dart';

class QuizController {
  int numberOfQuiz = 0;
  List<Quiz> quizList = [];
  List<Answer> answerList = [];

  QuizController(List<Map<String, dynamic>> wordsList) {
    for(final word in wordsList) { // word = {'id': id, 'word' : content}

      final Map<String, dynamic> content = word['word'];
      final String id = word['id'];
      final Map<String, String> phonetic = content['phonetics'].isEmpty ? {'text':'', 'audio':''} : content['phonetics'][0];

      Answer answer = new Answer(
        id: id,
        word: content['word'],
        phoneticAudio: phonetic['audio'],
        phoneticText: phonetic['text'],
      );
      List<Map<String, String>> meanings = word['meanings'];
      quizList.add(Quiz());
    }
  };

  void newQuizGame() {

  }

}