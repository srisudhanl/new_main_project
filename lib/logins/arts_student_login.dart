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
  bool showSpinner = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage("assets/student_login.gif"), fit: BoxFit.contain)),
              height: 200,
              width: double.infinity,
            ),
            SizedBox(height: 15),
            Container(
              height: 600,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  image: DecorationImage(image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover),
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)]),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  const Text(
                    'Login Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                    ), //TextStyle
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildTextField(
                        labelText: "Enter Email",
                        hintText: "email address",
                        textEditingController: emailController,
                        textInputType: TextInputType.emailAddress),
                  ),
                  Container(
                    color: Colors.transparent,
                    height: 20,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildTextField(
                        labelText: "Enter Password",
                        hintText: "Password",
                        textEditingController: passwordController,
                        textInputType: TextInputType.text),
                  ),
                  Container(
                    color: Colors.transparent,
                    height: 25,
                    width: double.infinity,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            textStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
                            shadowColor: Colors.blueGrey),
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final userCredential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                            final user = userCredential.user;
                            final userSnapShot = await FirebaseFirestore.instance
                                .collection('ArtsStudent')
                                .where("uid", isEqualTo: user?.uid)
                                .get();
                            if (!user!.emailVerified) {
                              await user.sendEmailVerification();
                              return ToastManager.showToastShort(msg: "Verification email sent. Check your inbox.");
                            }
                            if (userSnapShot.docs.isNotEmpty) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ArtsStudent()));
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
                        setState(() {
                          emailController.clear();
                          passwordController.clear();
                        });
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shadowColor: Colors.blueGrey),
                      child: const Text("Cancel", style: TextStyle(color: Colors.white)),
                    )
                  ]),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      style: TextButton.styleFrom(surfaceTintColor: Colors.purpleAccent),
                      onPressed: () =>
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordScreen())),
                      child: Text(
                        "Forget Password ?",
                        style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),
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
                            "Doesn't have an account!!",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: TextButton(
                              style:
                                  TextButton.styleFrom(textStyle: const TextStyle(fontSize: 15), shadowColor: Colors.redAccent),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ArtsStudentRegister()));
                              },
                              child: Text("Sign Up", style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ])),
        ));
  }
}
