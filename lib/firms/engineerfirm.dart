import 'package:flutter/material.dart';
import '../querypage.dart';

class engineerfirm extends StatefulWidget {
  const engineerfirm({Key? key}) : super(key: key);

  @override
  State<engineerfirm> createState() => _engineerfirmState();
}

class _engineerfirmState extends State<engineerfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('OVPC-engineerfirm',
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