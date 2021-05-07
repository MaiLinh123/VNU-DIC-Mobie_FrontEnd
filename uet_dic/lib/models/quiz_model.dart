
import 'package:uet_dic/models/word_model.dart';

class Quiz {
  String partOfSpeech;
  String question; // mean of a word
  Answer answer; // length = 4

  Quiz({this.partOfSpeech, this.question, this.answer});
}

class Answer {
  String id;
  String word;
  Phonetic phonetic;

  Answer({this.id, this.word, this.phonetic});
}