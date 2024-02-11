import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../querypage.dart';

class EngineerFirm extends StatefulWidget {
  const EngineerFirm({Key? key}) : super(key: key);

  @override
  State<EngineerFirm> createState() => _EngineerFirmState();
}

class _EngineerFirmState extends State<EngineerFirm> {
  bool _isLoading = false;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? engineer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _oninit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'OPSV',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.query_builder),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QueryPage(),
                  ),
                );
              },
            ),
          ], //TextStyle
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover)),
            ),
            _isLoading
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Please wait Data is fetching from Database"),
                        SizedBox(
                          height: 20,
                        ),
                        CircularProgressIndicator(),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: engineer?.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Material(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          elevation: 4,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              child: Text(
                                (engineer?[i].data()['firstname'] ?? "i").toString().substring(0, 1),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            title: Text(engineer?[i].data()['firstname']),
                            isThreeLine: true,
                            subtitle: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SSLC: ${engineer?[i].data()['SSLC']}',
                                  style: TextStyle(fontSize: 11),
                                ),
                                Text(
                                  'HSC: ${engineer?[i].data()['HSC']}',
                                  style: TextStyle(fontSize: 11),
                                ),
                                Text(
                                  'CGPA: ${engineer?[i].data()['CGPA']}',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ],
                            ),
                            contentPadding: const EdgeInsets.all(8),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            horizontalTitleGap: 20,
                            tileColor: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ));
  }

  Future<void> _oninit() async {
    _isLoading = true;
    refresh();
    final engineerCollection = await FirebaseFirestore.instance.collection('engineer').get();
    engineer = engineerCollection.docs;
    _isLoading = false;
    refresh();
  }

  void refresh() {
    if (this.mounted) setState(() {});
  }
}
