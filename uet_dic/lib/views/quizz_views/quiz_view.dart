import 'package:flutter/material.dart';
import 'package:uet_dic/share/app_card.dart';
import 'package:uet_dic/share/app_background.dart';

class QuizView extends StatelessWidget {

  @required final bool loading;
  @required final Widget child;
  final Widget appBar;
  const QuizView({this.loading, this.child, this.appBar});

  @override
  Widget build(BuildContext context) {

    final _quizViewBody = AppBackGround(
      aboveBackground: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: AppCard(
          child: Column(
            children: [
              ListTile(
                title: Text('a'),
              ),
            ],
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: this.appBar,
      resizeToAvoidBottomInset: false,
      body: _quizViewBody,
    );
  }
}
