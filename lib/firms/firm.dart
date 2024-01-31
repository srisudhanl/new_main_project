import 'package:flutter/material.dart';

import '../querypage.dart';

class firm extends StatefulWidget {
  const firm({Key? key}) : super(key: key);

  @override
  State<firm> createState() => _firmState();
}

class _firmState extends State<firm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('OVPC-firm',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color : Colors.white,
            fontSize: 15.0,
          ),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.query_builder),
            onPressed: (){
              Navigator.push(
                  context,MaterialPageRoute(builder:(context)=>QueryPage()));
            },
          ),
        ],//TextStyle
      ),
      body: Container(
        child: Center(
          child: Text("Need to connect to database"),
        ),
      ),
    );
  }
}
