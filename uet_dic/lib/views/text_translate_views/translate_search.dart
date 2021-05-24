import 'package:flutter/material.dart';
import 'package:uet_dic/controllers/translate_controller.dart';
import 'package:uet_dic/views/text_translate_views/translate_language.dart';
import 'package:uet_dic/views/text_translate_views/translate_result.dart';

class TranslateSearch extends StatelessWidget {

  final _searchController = TextEditingController();
  final GlobalKey<TranslateResultState> translateResultStateKey;
  final GlobalKey<TranslateLanguageState> translateLanguageKey;
  final FocusNode _inputFocusNode = FocusNode();

  TranslateSearch({this.translateResultStateKey, this.translateLanguageKey});

  @override
  Widget build(BuildContext context) {

    final _translateController = TranslateController();

    Future<void> _onSubmitted(String _searchWord) async {
      String sl = this.translateLanguageKey.currentState.sl;
      String tl = this.translateLanguageKey.currentState.tl;
      _searchWord = _searchWord.trim();
      if (_searchWord.trim().isNotEmpty) {
        translateResultStateKey.currentState.reload(isLoading: true);
        String result = await _translateController.translateText(_searchWord, sl, tl);
        translateResultStateKey.currentState.reload(result: result);
        print(result);
      } else {
        _searchController.clear();
      }
    }

    final _clearIcon = IconButton(
      padding: EdgeInsets.all(0.0),
      alignment: Alignment.topRight,
      icon: Icon(Icons.clear_rounded,),
      onPressed: () => _searchController.clear(),
    );

    final _submitIcon = IconButton(
      padding: EdgeInsets.all(0.0),
      iconSize: 21,
      alignment: Alignment.bottomRight,
      icon: Icon(Icons.send_rounded, color: Colors.green[400]),
      onPressed: () async {
        if(_inputFocusNode.hasFocus) {
          _inputFocusNode.unfocus();
          await _onSubmitted(_searchController.text);
        }
      },
    );

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: TextField(
        keyboardType: TextInputType.multiline,
        focusNode: _inputFocusNode,
        minLines: 5,
        maxLines: 5,
        textInputAction: TextInputAction.newline,
        controller: _searchController,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 15, right: 7, top: 7, bottom: 7),
          suffix: Column(
            children: [
              _clearIcon,
              _submitIcon,
            ],
          ),
          hintText: "Enter your text",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
        ),
        onSubmitted: _onSubmitted,
      ),
    );
  }
}
