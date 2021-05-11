import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:uet_dic/models/quiz_model.dart';

class QuizPagination extends SwiperPlugin {
  List<Quiz> quizList;
  SwiperPlugin builder;

  QuizPagination({this.quizList}) {
    int start = 0;
    int end = start + 5;
    this.builder = SwiperCustomPagination(
        builder: (BuildContext context, SwiperPluginConfig config) {
      List<Widget> list = [];
      int activeIndex = config.activeIndex;
      int itemCount = config.itemCount;

      if (activeIndex >= end || activeIndex < start) {
        start = activeIndex ~/ 5 * 5;
        end = start + 5;
      }
      if (itemCount < end) end = itemCount;

      if(start != 0) {
        list.add(GestureDetector(
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
          onTap: () => config.controller.move(start-1),
        ));
      }

      for (int i = start; i < end; ++i) {
        bool correct;
        if(this.quizList[i].isCheck) {
          correct = this.quizList[i].correct == this.quizList[i].chosen;
        }
        list.add(PaginationDot(
          text: '$i',
          correct: correct,
          active: i == activeIndex,
          onTap: () => config.controller.move(i),
        ));
      }

      if(end != itemCount) {
        list.add(
          GestureDetector(
            child: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
            ),
            onTap: () => config.controller.move(end),
          ),
        );
      }

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    });
  }

  Widget build(BuildContext context, SwiperPluginConfig config) {
    Widget child = Container(
      margin: EdgeInsets.all(10.0),
      child: this.builder.build(context, config),
    );
    return Align(
      alignment: Alignment.topCenter,
      child: child,
    );
  }
}

class PaginationDot extends StatelessWidget {
  final String text;
  final bool active;
  final bool correct;
  final Function() onTap;

  const PaginationDot({this.text, this.active, @required this.onTap, this.correct});

  @override
  Widget build(BuildContext context) {

    Color childColor = active ? Colors.green : Colors.white;
    Color backgroundColor = active ? Colors.white : Colors.green[400];

    Widget child;
    if(this.correct == null) {
      child = Text(
        text,
        style: TextStyle(
          color: childColor,
          fontWeight: FontWeight.bold,
        ),
      );
    }  else {
      child = this.correct
          ? Icon(Icons.check, color: childColor, size: 18,)
          : Icon(Icons.clear, color: childColor, size: 18,);
    }

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(7),
        child: child,
        width: 25,
        height: 25,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      onTap: onTap,
    );
  }
}
