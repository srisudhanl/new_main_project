import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_project1/firm_interview_over_view_screen.dart';
import 'firms/MBAfirm.dart';
import 'firms/engineerfirm.dart';
import 'firms/firm.dart';

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
      appBar:AppBar(
        title: const Text('OPSV-Division',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
        actions: [
          IconButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>FirmInterviewOverViewScreen(firmId: currentUserId!))), icon: Icon(Icons.info_outline_rounded))
        ],
      ),
      body: Container(
        width: double.infinity,
        height:double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.jpeg"),
                fit: BoxFit.cover)),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[Column(
            children: <Widget>[
              Container(
                width:double.infinity,
                height: 100,
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2)))
                        ,
                        shadowColor: Colors.blueGrey),
                    onPressed:() {
                      Navigator.push(
                          context,MaterialPageRoute(builder:(context)=>const ArtsFirm()));
                    },
                    child: const Text("Arts student",style:TextStyle(
                      fontSize:30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                      textAlign: TextAlign.center,)
                ),
              ),
            ],
          ),
            Column(
              children: <Widget>[

                Container(
                  width:double.infinity,
                  height: 100,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(2))),
                          shadowColor: Colors.blueGrey),
                      onPressed:() {
                        Navigator.push(
                            context,MaterialPageRoute(builder:(context)=>const EngineerFirm()));
                      },
                      child: const Text("Engineering Student",style:TextStyle(
                        fontSize:30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                        textAlign: TextAlign.center,)
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  width:double.infinity,
                  height: 100,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(2))),
                          shadowColor: Colors.blueGrey),
                      onPressed:() {
                        Navigator.push(
                            context,MaterialPageRoute(builder:(context)=>const MbaFirm()));
                      },
                      child: const Text("MBA Student",style:TextStyle(
                        fontSize:30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                        textAlign: TextAlign.center,)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}