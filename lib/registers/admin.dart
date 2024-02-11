import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../newfirm.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  late String company;
  late String address;
  late String email;
  late String phno;
  late String password;
  bool showspinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'OPSV-ADMIN',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ), //TextStyle
        ), //appBar
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover)),
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            const Text(
              'Fill Company Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35.0,
              ), //TextStyle
            ), //Text
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter Company Name:',
                hintText: 'Name',
              ), //InputDecoration
              autocorrect: true,
              onChanged: (value) {
                company = value;
              },
              keyboardType: TextInputType.text,
            ), //TextField
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter Address:',
                hintText: 'Address',
              ), //InputDecoration
              autocorrect: true,
              onChanged: (value) {
                address = value;
              },
              keyboardType: TextInputType.text,
            ), //TextField
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter Contact no:',
                hintText: 'ph.no',
              ), //InputDecoration
              autocorrect: true,
              onChanged: (value) {
                phno = value;
              },
              keyboardType: TextInputType.number,
            ), //TextField
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter Company email:',
                hintText: 'email',
              ), //InputDecoration
              autocorrect: true,
              onChanged: (value) {
                email = value;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter password:',
                hintText: 'password',
              ), //InputDecoration
              autocorrect: true,
              onChanged: (value) {
                password = value;
              },
              keyboardType: TextInputType.text,
            ), //TextField
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      textStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(2),
                        ),
                      ),
                      shadowColor: Colors.blueGrey),
                  onPressed: () async {
                    setState(() {
                      showspinner = true;
                    });
                    try {
                      Navigator.pop(context);
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(email: email, password: password)
                          .then((currentUser) => FirebaseFirestore.instance
                              .collection("Firms")
                              .doc(currentUser.user?.uid)
                              .set({
                                "uid": currentUser.user?.uid,
                                "Company": company,
                                "email": email,
                                "address": address,
                                "phno": phno,
                                "password": password,
                              })
                              .then((result) => {
                                    FirebaseAuth.instance
                                        .signOut()
                                        .then((result) => {
                                              Navigator.pop(context),
                                            })
                                        .catchError((err) => print(err)),
                                  })
                              .catchError((err) => print(err)));
                    } catch (e) {
                      if (kDebugMode) {
                        print(e);
                      }
                    }
                  },
                  child: const Text("Register/submit",style: TextStyle(color: Colors.white),),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Any new firms!!!",
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          textStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
                          shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                          shadowColor: Colors.blueGrey),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const NewFirm()));
                      },
                      child: const Text("Click Here",style: TextStyle(color: Colors.blue),),
                    ),
                  ),
                ],
              ),
            ),
          ])),
        ));
  }
}
