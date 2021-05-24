import 'package:flutter/material.dart';

PreferredSizeWidget MyAppBar({@required String title, Widget leading}) {
  return AppBar(
    brightness: Brightness.light,
    elevation: 5,
    backgroundColor: Colors.white,
    leading: leading,
    title: Text(
      title,
      style: TextStyle(color: Colors.green[400]),
    ),
    iconTheme: IconThemeData(
      color: Colors.green[400], //change your color here
    ),
  );
}
