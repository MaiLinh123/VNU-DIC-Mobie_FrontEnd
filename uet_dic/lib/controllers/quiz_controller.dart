import 'dart:math';

import 'package:uet_dic/models/quiz_model.dart';
import 'package:uet_dic/models/word_model.dart';

class QuizController {
  int numberOfQuiz = 0;
  int numberOfAnswer = 0;
  List<Quiz> quizList = [];
  List<Answer> answerList = [];

  QuizController(List<Word> wordsList) {
    for (final word in wordsList) {
      Answer answer = new Answer(
        id: word.id,
        word: word.word,
        phonetic: word.phonetic,
      );
      answerList.add(answer);
      quizList.add(Quiz(
        partOfSpeech: word.meanings[0].partOfSpeech,
        question: word.meanings[0].definition,
        trueAnswer: answer,
      ));
    }
    numberOfQuiz = quizList.length;
    numberOfAnswer = answerList.length;

    quizList.shuffle();
    for (int i = 0; i < numberOfQuiz; i++) {
      quizList[i].allAnswer = randomAnswers(quizList[i].trueAnswer);
    }
  }

  List<Answer> randomAnswers(Answer trueAns) {
    final random = Random();

    List<Answer> answerForQuiz = [trueAns];
    while (answerForQuiz.length != 4) {
      Answer falseAns = answerList[random.nextInt(numberOfAnswer)];
      if (trueAns.word != falseAns.word) answerForQuiz.add(falseAns);
    }

    answerForQuiz.shuffle();
    return answerForQuiz;
  }
}
