import 'package:flutter/material.dart';

import 'logins/mba_login.dart';
import 'logins/engineering_login.dart';
import 'logins/arts_student_login.dart';

class LoginDivision extends StatefulWidget {
  const LoginDivision({Key? key}) : super(key: key);

  @override
  State<LoginDivision> createState() => _LoginDivisionState();
}

class _LoginDivisionState extends State<LoginDivision> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OPSV - Division',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ArtsStudentLogin()));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      shadowColor: Colors.blueGrey),
                  child: Text(
                    "Login for Arts student",
                    style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.purple.shade900),
                    textAlign: TextAlign.center,
                  )),
            ),
            Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EngineeringLogin()));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      shadowColor: Colors.blueGrey),
                  child: Text(
                    "Login for engineering student",
                    style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.purple.shade900),
                    textAlign: TextAlign.center,
                  )),
            ),
            Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MbaLogin()));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      shadowColor: Colors.blueGrey),
                  child: Text(
                    "Login for MBA student",
                    style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.purple.shade900),
                    textAlign: TextAlign.center,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
