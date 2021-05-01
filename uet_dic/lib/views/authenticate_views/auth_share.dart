import 'package:flutter/material.dart';

final _myOutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(25.0),
    borderSide: BorderSide(
      color: Colors.green[400],
      width: 2.0,
    )
);

TextFormField myTextFormField({TextEditingController controller, IconData iconData, String hintText, String validator(String value), bool obscureText = false}) {
  return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        prefixIcon: Icon(
          iconData,
          color: Colors.green[400],
        ),
        enabledBorder: _myOutlineInputBorder,
        focusedBorder: _myOutlineInputBorder,
        errorBorder: _myOutlineInputBorder,
        focusedErrorBorder: _myOutlineInputBorder,
        hintText: hintText,
      ));
}

ElevatedButton myElevatedButton({Widget child, Function onPressed}) {
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