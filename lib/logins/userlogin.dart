import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../forget_password_screen.dart';
import '../querypage.dart';
import '../registers/firmcollect.dart';
import '../toast_manager.dart';
import '../userdivision.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
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
            'OVPC-USERLOGIN',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
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
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover)),
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, image: DecorationImage(image: AssetImage("assets/user_login.jpeg"), fit: BoxFit.cover)),
              height: 250,
              width: double.infinity,
            ),
            const Text(
              'Login Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35.0,
              ), //TextStyle
            ), //Text
            TextField(
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
            Container(
              color: Colors.transparent,
              height: 30,
              width: double.infinity,
            ),
            TextField(
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
            Container(
              color: Colors.transparent,
              height: 50,
              width: double.infinity,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                    final user = userCredential.user;
                    final userSnapShot = await FirebaseFirestore.instance.collection('Firms').where("uid", isEqualTo: user?.uid).get();
                    if (!user!.emailVerified) {
                      await user.sendEmailVerification();
                      return ToastManager.showToastShort(msg: "Verification email sent. Check your inbox.");
                    }
                    if (userSnapShot.docs.isNotEmpty) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const UserDivision()));
                    } else {
                      return ToastManager.showToastShort(msg: "You're request is in process.Please wait!!!");
                    }
                  } catch (e) {
                    if (kDebugMode) {
                      print(e);
                    }
                    return ToastManager.showToastShort(msg: "You're not authorized!!!");
                  }
                  setState(() {
                    showSpinner = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
                    shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                    shadowColor: Colors.blueGrey),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    textStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
                    shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                    shadowColor: Colors.blueGrey),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordScreen())),
                child: const Text(
                  "Forget Password ?",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Don't Have an Account!!",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green, shadowColor: Colors.redAccent),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const FirmCollect()));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ])),
        ));
  }
}
