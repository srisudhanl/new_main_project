import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../pages/student.dart';
import '../querypage.dart';
import '../registers/register.dart';

class ArtsStudentLogin extends StatefulWidget {
  const ArtsStudentLogin({Key? key}) : super(key: key);

  @override
  State<ArtsStudentLogin> createState() => _ArtsStudentLoginState();
}

class _ArtsStudentLoginState extends State<ArtsStudentLogin> {
  late String email;
  late String password;
  bool showSpinner = false;

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
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover)),
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            Container(
              width: double.infinity,
              height: 250,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://previews.123rf.com/images/tanyastock/tanyastock1803/tanyastock180300490/97923644-user-icon-avatar-login-sign-circle-button-with-soft-color-gradient-background-vector-.jpg"),
                      fit: BoxFit.cover)),
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
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Enter Email:',
                  hintText: 'email address',
                ), //InputDecoration
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
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
                      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                      if (user != null) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const student()));
                      }
                    } catch (e) {
                      if (kDebugMode) {
                        print(e);
                      }
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  },
                  child: const Text("Login",style: TextStyle(color: Colors.white),)),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ArtsStudentLogin()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    textStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
                    shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                    shadowColor: Colors.blueGrey),
                child: const Text("Cancel",style: TextStyle(color: Colors.white),),
              )
            ]),
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
                            textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green, shadowColor: Colors.redAccent),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ArtsStudentRegister()));
                        },
                        child: const Text("Sign Up",style: TextStyle(color: Colors.white),),
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
