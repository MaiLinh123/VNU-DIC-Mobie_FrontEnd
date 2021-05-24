import 'package:flutter/material.dart';
import 'package:uet_dic/share/app_loading.dart';

class TranslateResult extends StatefulWidget {
  const TranslateResult({Key key}) : super(key: key);

  @override
  TranslateResultState createState() => TranslateResultState();
}

class TranslateResultState extends State<TranslateResult> {
  String _translateResult = '';
  bool _isLoading = false;

  void reload({bool isLoading = false, String result = ''}) {
    setState(() {
      _isLoading = isLoading;
      _translateResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: AppLoading())
        : Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text('$_translateResult', style: TextStyle(fontSize: 17),),
          );
  }
}
