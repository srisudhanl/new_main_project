import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_project1/student_interview_over_view_screen.dart';

import '../querypage.dart';

class ArtsStudent extends StatefulWidget {
  const ArtsStudent({Key? key}) : super(key: key);

  @override
  State<ArtsStudent> createState() => _ArtsStudentState();
}

class _ArtsStudentState extends State<ArtsStudent> {
  late String myfirstname, mylastname, myaddress, myphno;
  late String mySSLC, myyop1, myHSC, myyop2;
  late String myCID, myCGPA, myyop3, myintern;
  late String myinplant, myAOI, mypassword, myEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OPSV-student',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StudentInterViewOverViewScreen()),
                  ),
              icon: const Icon(Icons.info_outline_rounded)),
          IconButton(
            icon: const Icon(Icons.query_builder),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const QueryPage()));
            },
          ),
        ], //TextStyle
      ),
      body: Center(
        child: FutureBuilder(
          future: _fetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Text("Loading data ... Please Wait");
            }
            return SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover)),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("FirstName       :$myfirstname"),
                    ),
                    ListTile(
                      title: Text("LastName        :$mylastname"),
                    ),
                    ListTile(
                      title: Text("Email           :$myEmail"),
                    ),
                    ListTile(
                      title: Text("Ph.No           :$myphno"),
                    ),
                    ListTile(
                      title: Text("Address         :$myaddress"),
                    ),
                    ListTile(
                      title: Text("SSLC I.D        :$mySSLC"),
                    ),
                    ListTile(
                      title: Text("Year of Passing :$myyop1"),
                    ),
                    ListTile(
                      title: Text("HSLC I.D        :$myHSC"),
                    ),
                    ListTile(
                      title: Text("Year of Passing :$myyop2"),
                    ),
                    ListTile(
                      title: Text("College I.D     :$myCID"),
                    ),
                    ListTile(
                      title: Text("Year of Passing :$myyop3"),
                    ),
                    ListTile(
                      title: Text("Internships     :$myintern"),
                    ),
                    ListTile(
                      title: Text("ImplantTraining :$myinplant"),
                    ),
                    ListTile(
                      title: Text("Area of Interest :$myAOI"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _fetch() async {
    final firebaseuser = await FirebaseAuth.instance.currentUser;
    if (firebaseuser != null) {
      await FirebaseFirestore.instance.collection('ArtsStudent').doc(firebaseuser.uid).get().then((ds) {
        myfirstname = ds.data()?['firstname'];
        mylastname = ds.data()?['lastname'];
        myaddress = ds.data()?['address'];
        myEmail = ds.data()?['email'];
        myphno = ds.data()?['phno'];
        mySSLC = ds.data()?['SSLC'];
        myyop1 = ds.data()?['yop1'];
        myHSC = ds.data()?['HSC'];
        myyop2 = ds.data()?['yop2'];
        myCID = ds.data()?['CID'];
        myCGPA = ds.data()?['CGPA'];
        myyop3 = ds.data()?['yop3'];
        myintern = ds.data()?['intern'];
        myinplant = ds.data()?['implant'];
        myAOI = ds.data()?['AOI'];
        mypassword = ds.data()?['password'];
      }).catchError((e) {
        print(e);
      });
    }
  }
}
