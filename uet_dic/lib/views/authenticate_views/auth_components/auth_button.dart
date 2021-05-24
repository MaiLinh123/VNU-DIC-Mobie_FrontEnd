import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  @required final Widget child;
  @required final void Function() onPressed;

  const AuthButton({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: child,
      style: ElevatedButton.styleFrom(
        primary: Colors.green[400], //background
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.all(14.0),
      ),
      onPressed: onPressed,
    );
  }
}
