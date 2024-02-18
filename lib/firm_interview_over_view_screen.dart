import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirmInterviewOverViewScreen extends StatefulWidget {
  final String firmId;

  const FirmInterviewOverViewScreen({required this.firmId, super.key});

  @override
  State<FirmInterviewOverViewScreen> createState() => _FirmInterviewOverViewScreenState();
}

class _FirmInterviewOverViewScreenState extends State<FirmInterviewOverViewScreen> {
  bool _isLoading = false;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? studentCalls;

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
            'Interview Overview',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
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
                    itemCount: studentCalls?.length,
                    itemBuilder: (context, i) {
                      return FutureBuilder(
                          future: getStudent(studentCalls![i].data()['studentId']),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: Material(
                                  elevation: 4,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text("First Name: ${snapshot.data?.data()['firstname']}"),
                                    isThreeLine: true,
                                    subtitle: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Email: ${snapshot.data?.data()['email']}"),
                                        Text("Ph.No: ${snapshot.data?.data()['phno']}")
                                      ],
                                    ),
                                    contentPadding: const EdgeInsets.all(8),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    horizontalTitleGap: 5,
                                    tileColor: Colors.white,
                                    // trailing: Padding(
                                    //   padding: const EdgeInsets.fromLTRB(0, 5, 8, 0),
                                    //   child: IconButton(
                                    //       onPressed: () => _deleteTheStudent(),
                                    //       icon: const Icon(
                                    //         Icons.delete_outline_rounded,
                                    //         color: Colors.red,
                                    //       )),
                                    // ),
                                  ),
                                ),
                              );
                            }
                            return const Center(
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
                            );
                          });
                    },
                  ),
          ],
        ));
  }

  Future<void> _oninit() async {
    _isLoading = true;
    refresh();
    final placementCollection = await FirebaseFirestore.instance.collection('Placement').where('firmId', isEqualTo: widget.firmId).get();
    studentCalls = placementCollection.docs;
    _isLoading = false;
    refresh();
  }

  Future<QueryDocumentSnapshot<Map<String, dynamic>>> getStudent(String uid) async {
    final artsStudent = await FirebaseFirestore.instance.collection('ArtsStudent').where('uid', isEqualTo: uid).get();
    final engineer = await FirebaseFirestore.instance.collection('engineer').where('uid', isEqualTo: uid).get();
    final mbaStudent = await FirebaseFirestore.instance.collection('MbaStudent').where('uid', isEqualTo: uid).get();
    if (artsStudent.docs.isNotEmpty) {
      return artsStudent.docs[0];
    } else if (engineer.docs.isNotEmpty) {
      return engineer.docs[0];
    }
    return mbaStudent.docs[0];
  }

  Future<void> _deleteTheStudent()async{
    print("delete is worrking");
    final result = await FirebaseFirestore.instance.collection('Placement').doc('uid').delete().then((value) => print("deletion complete"));
    print("delete complete");
  }

  void refresh() {
    if (this.mounted) setState(() {});
  }
}
