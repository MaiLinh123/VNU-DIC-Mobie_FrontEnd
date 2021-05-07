import 'package:uet_dic/models/quiz_model.dart';
import 'package:uet_dic/models/word_model.dart';

class QuizController {
  int numberOfQuiz = 0;
  List<Quiz> quizList = [];
  List<Answer> answerList = [];

  QuizController(List<Word> wordsList) {
    for(final word in wordsList) {
      Answer answer = new Answer(
        id: word.id,
        word: word.word,
        phonetic: word.phonetic,
      );
      for(final meaning in word.meanings) {
        quizList.add(Quiz(
          partOfSpeech: meaning.partOfSpeech,

        ));
      }
    }
  }

  void newQuizGame() {

  }

}