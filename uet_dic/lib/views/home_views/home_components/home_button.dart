import 'package:flutter/material.dart';
class HomeButton extends StatelessWidget {

  final IconData icon;
  final String label;
  final Function onPress;

  const HomeButton({this.icon, this.label, this.onPress});

  @override
  Widget build(BuildContext context) {
    return  FlatButton(
      padding: EdgeInsets.all(23),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white,),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      onPressed: onPress,
    );
  }
}
