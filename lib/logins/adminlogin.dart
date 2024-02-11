import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../registers/admin.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../toast_manager.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  late String email;
  late String password;
  bool showSpinner = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'OPSV-Admin Login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover)),
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            Container(
              height: 300,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/admin_login.jpeg"),
                      fit: BoxFit.cover)),
              width: double.infinity,
            ),
            const Text(
              'Login Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35.0,
              ), //TextStyle
            ), //Text
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Enter Email:',
                  hintText: 'email address',
                ), //InputDecoration
                autocorrect: false,
                onChanged: (value) {
                  email = value;
                },
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Container(
              color: Colors.transparent,
              height: 30,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Enter PassWord:',
                  hintText: 'Password',
                ),
                //InputDecoration
                autocorrect: false,
                onChanged: (value) {
                  password = value;
                },
                keyboardType: TextInputType.text,
              ),
            ),
            Container(
              color: Colors.transparent,
              height: 35,
              width: double.infinity,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
                    shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                    shadowColor: Colors.blueGrey),
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                    final user = userCredential.user;
                    final userSnapShot = await FirebaseFirestore.instance.collection('admin').where("email",isEqualTo: user?.email).get();
                    if (userSnapShot.docs.isNotEmpty) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Admin()));
                    }else{
                      ToastManager.showToastShort(msg: "You're not authorized!!!");
                    }
                  } catch (e) {
                    ToastManager.showToastShort(msg: "You're not authorized!!!");
                    if (kDebugMode) {
                      print(e);
                    }
                  }
                  setState(() {
                    showSpinner = false;
                  });
                },
                child: const Text("Login",style: TextStyle(color: Colors.white),),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    textStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
                    shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                    shadowColor: Colors.blueGrey),
                child: const Text("Cancel",style: TextStyle(color: Colors.white),),
              )
            ]),
          ])),
        ));
  }
}
