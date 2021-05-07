
class Quiz {
  String partOfSpeech;
  String question; // mean of a word
  Answer answer; // length = 4

  Quiz({this.partOfSpeech, this.question, this.answer});
}

class Answer {
  String id;
  String word;
  String phoneticText;
  String phoneticAudio;

  Answer({this.id, this.word, this.phoneticText, this.phoneticAudio});
}