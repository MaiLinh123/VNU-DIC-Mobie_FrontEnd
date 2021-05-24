import 'package:flutter/material.dart';

class AppBackGround extends StatelessWidget {
  final Widget aboveBackground;

  AppBackGround({this.aboveBackground});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.green[400],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
              ),
            ),
          ],
        ),
        this.aboveBackground
      ],
    );
  }
}
