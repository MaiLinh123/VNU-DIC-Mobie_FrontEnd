import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;

  AppCard({this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      shadowColor: Colors.green[900],
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: this.child,
    );
  }
}

