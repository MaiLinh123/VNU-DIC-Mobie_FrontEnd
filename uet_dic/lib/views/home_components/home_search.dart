import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/word_controller.dart';
import 'package:uet_dic/views/word_views/word_details_view.dart';

class HomeSearch extends StatelessWidget {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _wordController = Provider.of<WordController>(context);

    void _onSubmitted(String _searchWord) async {
      if(_searchWord.trim().isNotEmpty) {
        print('Searching for : $_searchWord');

        final result = await _wordController.getWord(_searchWord);
        if(result['statusCode'] == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WordDetailsView(words: result['words']),
            ),
          );
        } else {
          print(result['message']);
        }
      } else {
        _searchController.text = '';
      }
    }
    void _onPressedClearIcon() {_searchController.text = '';}

    final _clearIcon = IconButton(
      onPressed: _onPressedClearIcon,
      icon: Icon(Icons.clear_rounded, color: Colors.black),
    );
    final _searchIcon = Icon(
      Icons.search,
      color: Colors.black87,
    );
    final _textDecoration = InputDecoration(
        border: InputBorder.none,
        prefixIcon: _searchIcon,
        suffixIcon: _clearIcon,
        hintText: "Tra cứu từ điển Anh - Việt",
        hintStyle: TextStyle(color: Colors.grey, fontSize: 15)
    );
    final _boxDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
    );

    return Container(
          decoration: _boxDecoration,
          child: TextField(
            textInputAction: TextInputAction.search,
            controller: _searchController,
            decoration: _textDecoration,
            onSubmitted: _onSubmitted,
          ),
        );
  }
}
