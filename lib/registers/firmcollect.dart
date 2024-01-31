import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirmCollect extends StatefulWidget {
  const FirmCollect({Key? key}) : super(key: key);

  @override
  State<FirmCollect> createState() => _FirmCollectState();
}

class _FirmCollectState extends State<FirmCollect> {
  late String companyname;
  late String password;
  late String email;
  late String address;
  late String phno;
  final txtcompanyname = TextEditingController();
  final txtpassword = TextEditingController();
  final txtemail = TextEditingController();
  final txtaddress = TextEditingController();
  final txtphno = TextEditingController();

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

  bool showspinner = false;

  @override
  void dispose() {
    txtcompanyname.dispose();
    txtpassword.dispose();
    txtemail.dispose();
    txtaddress.dispose();
    txtphno.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OPSV',
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Text(
                'Fill Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35.0,
                ), //TextStyle
              ), //Text
              TextField(
                controller: txtcompanyname,
                decoration: const InputDecoration(
                  labelText: 'Enter Companyname:',
                  hintText: 'companyname',
                ),
                //InputDecoration
                autocorrect: true,
                onChanged: (value) {
                  companyname = value;
                },
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: txtaddress,
                decoration: const InputDecoration(
                  labelText: 'Enter address:',
                  hintText: 'address',
                ),
                //InputDecoration
                autocorrect: true,
                onChanged: (value) {
                  address = value;
                },
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller:txtphno,
                decoration: const InputDecoration(
                  labelText: 'Enter Contact no:',
                  hintText: 'Ph.no',
                ), //InputDecoration
                autocorrect: true,
                onChanged: (value) {
                  phno = value;
                },
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller:txtemail,
                decoration: const InputDecoration(
                  labelText: 'Enter email:',
                  hintText: 'email',
                ), //InputDecoration
                autocorrect: false,
                onChanged: (value) {
                  email = value;
                },
                keyboardType: TextInputType.text,
              ),
              TextField(
                //controller:txtfirstname,
                decoration: const InputDecoration(
                  labelText: 'Enter password:',
                  hintText: 'password',
                ), //InputDecoration
                autocorrect: true,
                onChanged: (value) {
                  password = value;
                },
                keyboardType: TextInputType.text,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            textStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
                            shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                            shadowColor: Colors.blueGrey),
                        onPressed: () async {
                          setState(() {
                            showspinner = true;
                          });
                          try {
                            FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: email,
                                password: password).then((currentUser) =>
                                FirebaseFirestore.instance.collection("FirmData")
                                    .doc(currentUser.user?.uid).set({
                                  "uid": currentUser.user?.uid,
                                  "companyname": companyname,
                                  "email": email,
                                  "address": address,
                                  "phno": phno,
                                  "password": password,
                                }).then((result) =>
                                {FirebaseAuth.instance.signOut().then((result) =>
                                {
                                  Navigator.pop(context),
                                  _showDialog(context, "Saved Successfully"),
                                }).catchError(
                                        (err) => print(err)),}).catchError((err) =>
                                    print(err)));
                          } catch (e) {
                            if (kDebugMode) {
                              print(e);
                            }
                          }
                        },
                        child: const Text("Submit",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            textStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
                            shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                            shadowColor: Colors.blueGrey),
                        child: const Text("Clear",style: TextStyle(color: Colors.white),),
                        onPressed: () {
                          txtcompanyname.clear();
                          txtemail.clear();
                          txtaddress.clear();
                          txtphno.clear();
                          txtpassword.clear();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
