import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:main_project1/custom_widgets/custom_text_field.dart';

import '../forget_password_screen.dart';
import '../pages/arts_student.dart';
import '../querypage.dart';
import '../registers/register.dart';
import '../toast_manager.dart';

class ArtsStudentLogin extends StatefulWidget {
  const ArtsStudentLogin({Key? key}) : super(key: key);

  @override
  State<ArtsStudentLogin> createState() => _ArtsStudentLoginState();
}

class _ArtsStudentLoginState extends State<ArtsStudentLogin> {
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'OPSV - Student Login',
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
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover)),
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            Container(
              width: double.infinity,
              height: 250,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage("assets/engineering_login.jpeg"), fit: BoxFit.cover)),
            ),

            const Text(
              'Student Login',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35.0,
              ), //TextStyle
            ), //Text
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildTextField(
                labelText: 'Enter Email:',
                hintText: 'email address',
                textInputType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
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
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  password = value;
                },
              ),
            ),
            Container(
              color: Colors.transparent,
              height: 15,
              width: double.infinity,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
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
                      showSpinner = true;
                    });
                    try {
                      final userCredential =
                          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                      final user = userCredential.user;
                      final userSnapShot =
                          await FirebaseFirestore.instance.collection('ArtsStudent').where("uid", isEqualTo: user?.uid).get();
                      if (!user!.emailVerified) {
                        await user.sendEmailVerification();
                        return ToastManager.showToastShort(msg: "Verification email sent. Check your inbox.");
                      }
                      if (userSnapShot.docs.isNotEmpty) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Student()));
                      } else {
                        return ToastManager.showToastShort(msg: "You're not authorized!!!");
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
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  )),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ArtsStudentLogin()));
                },
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                            backgroundColor: Colors.green,
                            shadowColor: Colors.redAccent),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ArtsStudentRegister()));
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
