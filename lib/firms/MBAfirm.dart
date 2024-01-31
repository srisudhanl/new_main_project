import 'package:flutter/material.dart';
import '../querypage.dart';

class MBAfirm extends StatefulWidget {
  const MBAfirm({Key? key}) : super(key: key);

  @override
  State<MBAfirm> createState() => _MBAfirmState();
}

class _MBAfirmState extends State<MBAfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('OVPC-MBAfirm',
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