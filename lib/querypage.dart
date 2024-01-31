import 'package:flutter/material.dart';

class QueryPage extends StatefulWidget {
  const QueryPage({Key? key}) : super(key: key);

  @override
  State<QueryPage> createState() => _QueryPageState();
}

Future _showDialog(BuildContext context, String message) async {
  return showDialog(
      builder: (context) => AlertDialog(
            title: Text(message),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("ok"))
            ],
          ),
      context: context);
}

class _QueryPageState extends State<QueryPage> {
  late String query;
  final txtquery = TextEditingController();
  bool showSpinner = false;

  @override
  void dispose() {
    txtquery.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OPSV-Query',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ), //TextStyle
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover)),
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Fill Query',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35.0,
                ), //TextStyle
              ),
            ), //Text
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: txtquery,
                decoration: const InputDecoration(
                  labelText: 'Enter Query:',
                  hintText: 'Queries',
                ),
                //InputDecoration
                autocorrect: true,
                onChanged: (value) {
                  query = value;
                },
                keyboardType: TextInputType.text,
              ),
            ),
            Container(
              width: double.infinity,
              height: 35,
              color: Colors.transparent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showDialog(context, "Your Query is being processed.");
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          textStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
                          shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(2),
                            ),
                          ),
                          shadowColor: Colors.blueGrey),
                      child: const Text("Register/submit",style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    txtquery.clear();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(2),
                        ),
                      ),
                      shadowColor: Colors.blueGrey),
                  child: const Text("Clear",style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
