import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/word_controller.dart';
import 'package:uet_dic/views/word_views/word_details_view.dart';

class HomeSearch extends StatelessWidget {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _wordController = Provider.of<WordController>(context, listen: false);

    void _onSubmitted(String _searchWord) async {
      if (_searchWord.trim().isNotEmpty) {
        final result = await _wordController.queryWord(_searchWord);
        if (result['statusCode'] == 200) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => WordDetailsView(words: result['words']),
            ),
            ModalRoute.withName('/'),
          );
        }
      } else {
        _searchController.clear();
      }
    }
    void _onPressedClearIcon() {
      _searchController.clear();
    }
    final _clearIcon = IconButton(
      onPressed: _onPressedClearIcon,
      icon: Icon(Icons.clear_rounded, color: Colors.black),
    );
    final _searchIcon = IconButton(
      icon: Icon(Icons.search, color: Colors.black87),
      onPressed: () async {
        _onSubmitted(_searchController.text);
      },
    );
    final _textDecoration = InputDecoration(
        border: InputBorder.none,
        prefixIcon: _searchIcon,
        suffixIcon: _clearIcon,
        hintText: "Tra cứu từ điển Anh - Anh",
        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
    );
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      child: TextField(
        textInputAction: TextInputAction.search,
        controller: _searchController,
        decoration: _textDecoration,
        onSubmitted: _onSubmitted,
      ),
    );
  }
}
