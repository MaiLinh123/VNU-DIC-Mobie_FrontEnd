import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => new _SearchState();
}

class _SearchState extends State<Search> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
          child: Column(
            /*crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,*/
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[

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
              /*ElevatedButton(
                child: Text('EXPLORE'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[400],//background
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0)),
                  padding: EdgeInsets.all(15.0),
                ), onPressed: () { },
              ),*/
              SizedBox(
                width: 400.0,
                height: 50.0,
                child: ElevatedButton(
                  //style: Colors.green[400],
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                              Icons.account_box_rounded,
                              size: 20,
                              color: Colors.black),
                        ),
                        TextSpan(
                            text: ' Từ của bạn',
                            style: TextStyle(
                                fontSize: 20,/*fontWeight: FontWeight.bold,*/
                                color: Colors.black,
                                ),
                        ),
                      ],
                    ),
                    //textAlign: TextAlign.right,
                  ),
                  onPressed: (){},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                ),
              ),SizedBox(height: 10),
              SizedBox(
                width: 400.0,
                height: 50.0,
                child: ElevatedButton(
                  //style: Colors.green[400],
                  child: new Text(
                    'Từ đã tra',
                    textAlign: TextAlign.right,
                  ),
                  onPressed: (){},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green[400]),
                  ),
                ),
              ),SizedBox(height: 10),
              SizedBox(
                width: 400.0,
                height: 50.0,
                child: ElevatedButton(
                  //style: Colors.green[400],
                  child: new Text(
                    'Từ vựng thông dụng',
                    textAlign: TextAlign.right,
                  ),
                  onPressed: (){},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green[400]),
                  ),
                ),
              )
            ],
        ),
      ),
    );
  }
}