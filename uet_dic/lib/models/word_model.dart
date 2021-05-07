class Word {
  String id;
  String word;
  Phonetic phonetic;
  List<Meaning> meanings;

  Word({this.id, this.word, this.phonetic, this.meanings});

  factory Word.fromJson(Map word) {
    List phonetics = word['phonetics'];
    List<Meaning> meaningsList = [];

    for (final meaning in word['meanings']) {
      for (final definition in meaning['definitions']) {
        meaningsList.add(
          Meaning(
            partOfSpeech: meaning['partOfSpeech'],
            definition: definition['definition'],
            example: definition['example'] ,
            synonyms: definition['synonyms'] != null ? definition['synonyms'].join(',  ') : null,
          ),
        );
      }
    }

    return Word(
      id: word['_id'],
      word: word['word'],
      meanings: meaningsList,
      phonetic: phonetics.isNotEmpty ? Phonetic.fromJson(phonetics[0]) : Phonetic(),
    );
  }
}

class Meaning {
  String partOfSpeech;
  String definition;
  String example;
  String synonyms;

  Meaning({this.partOfSpeech, this.definition, this.example, this.synonyms});
}

class Phonetic {
  String text;
  String audio;

  Phonetic({this.text = "", this.audio = ""});

  factory Phonetic.fromJson(Map phonetic) {
    return Phonetic(
      text: phonetic['text'],
      audio: phonetic['audio'],
    );
  }
}
/*
example a query from sever
{
    "words":
    [
        {
            "phonetics": [ {"text": "text1", "audio": "text1"},{"text": "text2", "audio": "text2"} ... ],
            "meanings": [
                {
                    "partOfSpeech": "intransitive verb",
                    "definitions":
                    [
                        {"definition": "definition1", "synonyms": [...], "example": "example1"},
                        {"definition": "definition2", "synonyms": [...], "example": "example2"},
                        {"definition": "definition3", "synonyms": [...], "example": "example3"}
                        ...
                    ]
                }
            ],
            "_id": "_id1",
            "word": "word1",
            "query_word": "query_word1"
        },
        {...},
        {...},
        ...
    ]
}
*/
