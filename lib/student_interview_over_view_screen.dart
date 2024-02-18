import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentInterViewOverViewScreen extends StatefulWidget {
  const StudentInterViewOverViewScreen({super.key});

  @override
  State<StudentInterViewOverViewScreen> createState() => _StudentInterViewOverViewScreenState();
}

class _StudentInterViewOverViewScreenState extends State<StudentInterViewOverViewScreen> {
  bool _isLoading = false;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? interViews;
  final studentId = FirebaseAuth.instance.currentUser?.uid;
  late ConfettiController controller = ConfettiController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _oninit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                  itemCount: interViews?.length,
                  itemBuilder: (context, i) {
                    return FutureBuilder(
                      future: getFirm(interViews?[i].data()['firmId']),
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
                                title: Text("Firm Name: ${snapshot.data?.data()['Company']}"),
                                isThreeLine: true,
                                subtitle: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Address: ${snapshot.data?.data()['address']}"),
                                    Text("Email: ${snapshot.data?.data()['email']}"),
                                    Text("Phone no: ${snapshot.data?.data()['phno']}"),
                                  ],
                                ),
                                onTap: (){
                                  controller.play();
                                  _showMsgDialog(interViews?[i].data()['msg']);},
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
                      },
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
    final placementCollection = await FirebaseFirestore.instance.collection('Placement').where('studentId', isEqualTo: studentId).get();
    interViews = placementCollection.docs;
    _isLoading = false;
    refresh();
  }

  Future<QueryDocumentSnapshot<Map<String, dynamic>>> getFirm(String uid) async {
    final firms = await FirebaseFirestore.instance.collection('Firms').where('uid', isEqualTo: uid).get();
    return firms.docs[0];
  }

  void _showMsgDialog(String msg) {
    showDialog(
      context: context,
      builder: (context) => SizedBox(
        height: 200,
        width: 200,
        child: AlertDialog(
          title: const Center(child: Text("Interview Details")),
          contentPadding: const EdgeInsets.all(8),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          content: Stack(
            children: [
              Container(
                height: 100,
                width: 200,
                child: Align(
                  alignment: Alignment.center,
                  child: ConfettiWidget(
                    confettiController: controller,
                    blastDirectionality: BlastDirectionality.explosive,
                    colors: const [Colors.red, Colors.green, Colors.blue, Colors.pink],
                    numberOfParticles: 15,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(msg),
                    const SizedBox(height: 20,),
                    const Text("For more details,Please contact us.")
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            )
          ],
          actionsAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  void refresh() {
    if (this.mounted) setState(() {});
  }
}
