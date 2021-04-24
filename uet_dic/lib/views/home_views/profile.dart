import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 400.0,
            height: 150.0,
            child: ElevatedButton(
              //style: Colors.green[400],
              child: new Container(color: Colors.grey[800], child: new Column(children: <Widget>[
                new Align(alignment: Alignment.center,
                    child: new Text("Username"),
                ),
                Center(
                  child: CircleAvatar(
                    //backgroundImage: AssetImage("assets/image_icon/avatar.png"),
                    radius: 40.0,
                  ),
                ),
              ],)),
              onPressed: (){},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[800]),
              ),
            ),
          ),SizedBox(height: 10),
          SizedBox(
            width: 400.0,
            height: 70.0,
            child: ElevatedButton(
              //style: Colors.green[400],
              child: new Container(color: Colors.grey[800], child: new Column(
                children: <Widget>[
                  new Align(alignment: Alignment.topLeft, child: new Text("Username")),
              ],)),
              onPressed: (){},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[800]),
              ),
            ),
          ),SizedBox(height: 10),
          SizedBox(
            width: 400.0,
            height: 70.0,
            child: ElevatedButton(
              //style: Colors.green[400],
              child: new Container(color: Colors.grey[800],
                  child: new Column(
                    children: <Widget>[
                      new Align(
                          alignment: Alignment.centerLeft,
                          child: new Text("Password")
                      ),
                      ],
                  )
              ),
              onPressed: (){},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[800]),
              ),
            ),
          ),SizedBox(height: 10),
        ]
      )
    );
  }
}
