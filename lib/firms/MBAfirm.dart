import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../querypage.dart';
import '../toast_manager.dart';

class MbaFirm extends StatefulWidget {
  const MbaFirm({Key? key}) : super(key: key);

  @override
  State<MbaFirm> createState() => _MbaFirmState();
}

class _MbaFirmState extends State<MbaFirm> {
  bool _isLoading = false;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? mbaStudent;

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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const QueryPage()));
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
                  itemCount: mbaStudent?.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        elevation: 4,
                        child: ListTile(
                          leading: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.redAccent,
                                child: Text(
                                  (mbaStudent?[i].data()['firstname'] ?? "i").toString().substring(0, 1),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          title: Text(mbaStudent?[i].data()['firstname']),
                          isThreeLine: true,
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SSLC: ${mbaStudent?[i].data()['SSLC']}',
                                style: TextStyle(fontSize: 11),
                              ),
                              Text(
                                'HSC: ${mbaStudent?[i].data()['HSC']}',
                                style: TextStyle(fontSize: 11),
                              ),
                              Text(
                                'CGPA: ${mbaStudent?[i].data()['CGPA']}',
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
                          horizontalTitleGap: 15,
                          tileColor: Colors.white,
                          onTap: () => _showDetailsDailog(mbaStudent![i]),
                        ),
                      ),
                    );
                  },
                )
        ],
      ),
    );
  }

  Future<void> _oninit() async {
    _isLoading = true;
    refresh();
    final mbaCollection = await FirebaseFirestore.instance.collection('MbaStudent').get();
    mbaStudent = mbaCollection.docs;
    _isLoading = false;
    refresh();
  }

  Future<void> _showDetailsDailog(QueryDocumentSnapshot<Map<String, dynamic>> student) async {
    showDialog(
      context: context,
      builder: (context) => SizedBox(
        height: 200,
        child: AlertDialog(
          elevation: 4,
          title: const Center(child: Text("Student Details")),
          contentPadding: const EdgeInsets.all(10),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Table(
                  border: const TableBorder(),
                  columnWidths: const <int, TableColumnWidth>{
                    0: IntrinsicColumnWidth(),
                    1: IntrinsicColumnWidth(),
                    2: IntrinsicColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        const Text('First Name'),
                        const Text(':'),
                        Text(student.data()['firstname']),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text('Last Name'),
                        const Text(':'),
                        Text(student.data()['lastname']),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text('Address'),
                        const Text(':'),
                        Text(student.data()['address']),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text('Email'),
                        const Text(':'),
                        Text(student.data()['email']),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text('Phone Number'),
                        const Text(':'),
                        Text(student.data()['phno']),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text('CGPA'),
                        const Text(':'),
                        Text(student.data()['CGPA']),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text('HSC Mark'),
                        const Text(':'),
                        Text(student.data()['HSC']),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text('SSLC Mark'),
                        const Text(':'),
                        Text(student.data()['SSLC']),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text('Year Of Passing'),
                        const Text(':'),
                        Text(student.data()['yop3']),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text('Area of Interest'),
                        const Text(':'),
                        Text(student.data()['AOI']),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          actionsPadding: const EdgeInsets.all(10),
          actions: [
            TextButton(
              onPressed: () async {
                final currentUserId = FirebaseAuth.instance.currentUser?.uid;
                final currentUser = await FirebaseFirestore.instance.collection('Firms').where('uid', isEqualTo: currentUserId).get();
                final docId = FirebaseFirestore.instance.collection('Placement').doc().id;
                await FirebaseFirestore.instance.collection('Placement').doc(docId).set(
                    {
                      'firmId':currentUserId,
                      'studentId':student.data()['uid'],
                      'uid':docId,
                      'msg':"Hi,${student.data()['firstname']}. You are Selected for an Interview in ${currentUser.docs[0].data()['Company']}.If you are interested, contact us.",
                      'firmAddress':currentUser.docs[0].data()['address'],
                      'firmPhno':currentUser.docs[0].data()['phno'],
                      'firmEmail':currentUser.docs[0].data()['email']
                    }
                ).then((value) => {
                  debugPrint("Data Saved.And student is informed"),
                  ToastManager.showToastShort(msg: "Student is intimated."),
                  Navigator.pop(context)
                });
              },
              child: const Text(
                "Call For Interview",
              ),
            ),
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                ))
          ],
        ),
      ),
    );
  }

  void refresh() {
    if (this.mounted) setState(() {});
  }
}
