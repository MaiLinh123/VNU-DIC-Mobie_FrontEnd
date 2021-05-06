import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: Colors.green[400],
      size: 40.0,
    );
  }
}

void showToast(String message, int statusCode) {
  Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: statusCode == 200 ? Colors.green[400] : Colors.red[400],
      fontSize: 12);
}
