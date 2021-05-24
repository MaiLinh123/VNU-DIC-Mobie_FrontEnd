import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:uet_dic/controllers/authenticate_controller.dart';
import 'package:uet_dic/controllers/quiz_controller.dart';
import 'package:uet_dic/models/user_model.dart';
import 'package:uet_dic/models/word_model.dart';
import 'package:uet_dic/share/app_background.dart';
import 'package:uet_dic/share/app_bar.dart';
import 'package:uet_dic/share/app_loading.dart';
import 'package:uet_dic/views/quiz_views/quiz_card.dart';
import 'package:uet_dic/views/quiz_views/quiz_pagination.dart';
import 'package:uet_dic/share/app_card.dart';

class QuizView extends StatelessWidget {
  QuizView();

  @override
  Widget build(BuildContext context) {
    final User currentUser =
        Provider.of<AuthenticateController>(context, listen: false).currentUser;

    return FutureBuilder<List<Word>>(
      initialData: [],
      future: currentUser.getFavouriteListByID(),
      builder: (context, AsyncSnapshot snap) {
        final List<Word> favouriteList = snap.data;

        Widget quizCards = Padding(
          padding: EdgeInsets.only(left: 25, top: 30, right: 25, bottom: 0),
          child: AppCard(
            child: AppLoading(),
          ),
        );

        if (favouriteList.length == currentUser.wordIdMap.length) {
          if (favouriteList.length < 6) {
            quizCards = Padding(
              padding: EdgeInsets.only(left: 25, top: 30, right: 25, bottom: 0),
              child: AppCard(
                child: Text('You must have at least 6 words favoured'),
              ),
            );
          }
          else {
            final QuizController quizController = QuizController(favouriteList);
            quizCards = Swiper(
              pagination: QuizPagination(quizList: quizController.quizList),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SizedBox(height: 60,),
                    Expanded(
                      child: QuizCard(
                        quiz: quizController.quizList[index],
                      ),
                    ),
                  ],
                );
              },
              itemCount: quizController.numberOfQuiz,
              viewportFraction: 0.85,
              scale: 0.9,
              loop: false,
            );
          }
        }

        return Scaffold(
          appBar: MyAppBar(title: 'Quizzes'),
          resizeToAvoidBottomInset: false,
          body: AppBackGround(
            aboveBackground: quizCards,
          ),
        );
      },
    );
  }
}
