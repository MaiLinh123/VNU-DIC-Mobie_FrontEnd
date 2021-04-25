import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uet_dic/models/word_model.dart';

void main() async {
  var url = Uri.parse('http://localhost:3333/api/word/query/hello');
  var response = await http.get(url);
  final parsed = json.decode(response.body) as Map;
  // JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  // String prettyprint = encoder.convert(parsed);
  // print(prettyprint);
  // print(parsed['word']);
  // print(parsed['words'][0]['meanings'][0]);
  Word long = new Word.fromJson(parsed['words'][0]);

  print(parsed['words'][0]['_id']);
}
