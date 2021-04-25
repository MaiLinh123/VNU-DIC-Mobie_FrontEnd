class Word {

  String word;
  List<Phonetic> phonetics;
  List<Meaning> meanings;
  String id;

  Word({this.word, this.phonetics, this.meanings, this.id}) {
    print('Create word successful : ${this.word}');
  }

  factory Word.fromJson(Map<String, dynamic> wordJson) {
    String _word = wordJson['word'];
    List<Phonetic> _phonetics = [];
    List<Meaning> _meanings = [];
    String _id = wordJson['_id'];
    for(final phonetic in wordJson['phonetics']) {
      _phonetics.add(new Phonetic.fromJson(phonetic));
    }
    for(final meaning in wordJson['meanings']) {
      _meanings.add(new Meaning.fromJson(meaning));
    }

    return Word(
        word: _word,
        phonetics : _phonetics,
        meanings: _meanings,
        id: _id
    );
  }
}

class Phonetic {
  String text;
  String audio;
  Phonetic({this.text, this.audio});

  factory Phonetic.fromJson(Map<String, dynamic> phoneticJson) {
    return Phonetic(
      text: phoneticJson['text'],
      audio: phoneticJson['audio']
    );
  }
}

class Meaning {
  String partOfSpeech;
  List<Definition> definitions;

  String get _partOfSpeech => this.partOfSpeech;
  List<Definition> get _definitions => this.definitions;

  Meaning({this.partOfSpeech, this.definitions});

  factory Meaning.fromJson(Map<String, dynamic> meaningJson) {

    String _partOfSpeech = meaningJson['partOfSpeech'];
    List<Definition> _definitions = [];

    for(final definition in meaningJson['definitions']) {
      _definitions.add(new Definition.fromJson(definition));
    }

    return Meaning(
        partOfSpeech: _partOfSpeech,
        definitions: _definitions
    );
  }
}

class Definition {
  String definition;
  List<dynamic> synonyms;
  String example;

  Definition({this.definition, this.synonyms,this.example});

  factory Definition.fromJson(Map<String, dynamic> definitionJson) {
    return Definition(
        definition: definitionJson['definition'],
        synonyms: definitionJson['synonyms'],
        example: definitionJson['example']
    );
  }

}