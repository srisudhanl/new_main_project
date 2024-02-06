import 'package:flutter/material.dart';

class newfirm extends StatefulWidget {
  const newfirm({Key? key}) : super(key: key);

  @override
  State<newfirm> createState() => _newfirmState();
}

class _newfirmState extends State<newfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('OPSV-firm',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color : Colors.white,
            fontSize: 15.0,
          ),),//TextStyle
      ),
      body: Container(
        child: Center(
            child: Text("need to connect database")
        ),
      ),
    );
  }
}
