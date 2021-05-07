class Word {
  String id;
  String word;
  String phoneticText;
  String phoneticAudio;
  List<Meaning> meanings;

  Word({this.id, this.word, this.phoneticText, this.phoneticAudio, this.meanings});
}

class Meaning {
  String partOfSpeech;
  String definition;
  String example;
  String synonyms;

  Meaning({this.partOfSpeech, this.definition, this.example, this.synonyms});
}