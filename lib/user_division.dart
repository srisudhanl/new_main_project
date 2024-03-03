import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_project1/firm_interview_over_view_screen.dart';
import 'firms/mba_firm.dart';
import 'firms/engineer_firm.dart';
import 'firms/arts_firm.dart';

class UserDivision extends StatefulWidget {
  const UserDivision({Key? key}) : super(key: key);

  @override
  State<UserDivision> createState() => _UserDivisionState();
}

class _UserDivisionState extends State<UserDivision> {
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'OPSV-Division',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => FirmInterviewOverViewScreen(firmId: currentUserId!))),
                icon: Icon(Icons.info_outline_rounded))
          ],
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ArtsFirm()));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        shadowColor: Colors.blueGrey),
                    child: Text(
                      "Arts student",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const EngineerFirm()));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        shadowColor: Colors.blueGrey),
                    child: Text(
                      "Engineering student",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MbaFirm()));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        shadowColor: Colors.blueGrey),
                    child: Text(
                      "MBA student",
                      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.purple.shade900),
                      textAlign: TextAlign.center,
                    )),
              ),
            ],
          ),
        ));
  }
}
