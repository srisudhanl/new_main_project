import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:main_project1/custom_widgets/custom_text_field.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            Container(
              height: 300,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage("assets/admin_login.jpeg"), fit: BoxFit.cover)),
              width: double.infinity,
            ),
            Container(
              height: 600,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
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
                  ), //Text
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildTextField(
                      labelText: 'Enter Email',
                      hintText: 'email address',
                      textEditingController: emailController,
                      textInputType: TextInputType.emailAddress,
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    height: 20,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildTextField(
                      textInputType: TextInputType.text,
                      textEditingController: passwordController,
                      labelText: 'Enter PassWord',
                      hintText: 'Password',
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    height: 35,
                    width: double.infinity,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green, shadowColor: Colors.blueGrey),
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          final userCredential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                          final user = userCredential.user;
                          final userSnapShot =
                              await FirebaseFirestore.instance.collection('admin').where("email", isEqualTo: user?.email).get();
                          if (userSnapShot.docs.isNotEmpty) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Admin()));
                          } else {
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
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          emailController.clear();
                          passwordController.clear();
                        });
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shadowColor: Colors.blueGrey),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ]),
                ],
              ),
            ),
          ])),
        ));
  }
}
