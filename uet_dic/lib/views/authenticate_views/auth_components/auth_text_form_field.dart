import 'package:flutter/material.dart';
import 'package:uet_dic/views/authenticate_views/auth_components/auth_input_border.dart';

class AuthTextFormField extends StatelessWidget {
  @required final TextEditingController controller;
  @required final IconData iconData;
  @required final String hintText;
  @required final String Function(String) validator;
  final bool obscureText;

  const AuthTextFormField({this.controller, this.iconData, this.hintText, this.validator, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
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
          enabledBorder: authInputBorder,
          focusedBorder: authInputBorder,
          errorBorder: authInputBorder,
          focusedErrorBorder: authInputBorder,
          hintText: hintText,
        ),
      textInputAction: TextInputAction.next,
    );
  }
}
