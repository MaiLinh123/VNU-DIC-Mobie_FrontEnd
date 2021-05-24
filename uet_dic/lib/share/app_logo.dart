import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          Icons.auto_stories,
          size: 80,
          color: Colors.green,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'VNU',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[400],
                  fontSize: 40),
            ),
            Text(
              'Dictionary',
              style: TextStyle(color: Colors.green[400], fontSize: 30),
            )
          ],
        ),
      ],
    );
  }
}
