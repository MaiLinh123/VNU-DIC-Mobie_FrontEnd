import 'package:flutter/material.Dart';
class Search extends StatefulWidget {
  @override
  _SearchState createState() => new _SearchState();
}

class _SearchState extends State<Search> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Text(
                  //   'VNU-DIC',
                  //   style: TextStyle(color: Colors.blue, fontSize: 35, fontWeight: FontWeight.bold),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),

                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(244, 243, 243,1),
                        borderRadius: BorderRadius.circular(25)),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black87,
                          ),
                          suffixIcon: IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.mic, color: Colors.black87),
                          ),
                          hintText: "Tra cứu từ điển Anh - Việt",
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 15)),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}