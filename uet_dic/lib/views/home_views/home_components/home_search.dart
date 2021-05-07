import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/word_controller.dart';
import 'package:uet_dic/views/word_views/word_details_view.dart';

class HomeSearch extends StatelessWidget {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final wordController = Provider.of<WordController>(context, listen: false);

    void onSubmitted(String _searchWord) async {
      if (_searchWord.trim().isNotEmpty) {
        final result = await wordController.queryWord(_searchWord);
        if (result['statusCode'] == 200) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => WordDetailsView(wordsList: result['queriedWordsList']),
            ),
            ModalRoute.withName('/'),
          );
        }
      } else {
        _searchController.clear();
      }
    }

    final clearIcon = IconButton(
      onPressed: () => _searchController.clear(),
      icon: Icon(Icons.clear_rounded, color: Colors.black),
    );

    final searchIcon = IconButton(
      icon: Icon(Icons.search, color: Colors.black87),
      onPressed: ()  {
        onSubmitted(_searchController.text);
      },
    );

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      child: TextField(
        textInputAction: TextInputAction.search,
        controller: _searchController,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: searchIcon,
          suffixIcon: clearIcon,
          hintText: "Tra cứu từ điển Anh - Anh",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
