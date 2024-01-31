import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ArtsStudentRegister extends StatefulWidget {
  const ArtsStudentRegister({Key? key}) : super(key: key);

  @override
  State<ArtsStudentRegister> createState() => _ArtsStudentRegisterState();
}

class _ArtsStudentRegisterState extends State<ArtsStudentRegister> {
  late String firstname, lastname, email, address;
  late String phno, aadhar, aaphar, password;
  late String cpassword, intern, implant, aoi;
  late String sslcMark, hslcMark, cgpa, cid;
  late String yop1, yop2, yop3;

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

  final txtfirstname = TextEditingController();
  final txtlastname = TextEditingController();
  final txtemail = TextEditingController();
  final txtaddress = TextEditingController();
  final txtphno = TextEditingController();
  final txtaadhar = TextEditingController();
  final txtaaphar = TextEditingController();
  final txtintern = TextEditingController();
  final txtimplant = TextEditingController();
  final txtaoi = TextEditingController();
  final txtpassword = TextEditingController();
  final txtcpassword = TextEditingController();
  bool showSpinner = false;

  @override
  void dispose() {
    txtfirstname.dispose();
    txtlastname.dispose();
    txtemail.dispose();
    txtaddress.dispose();
    txtaaphar.dispose();
    txtphno.dispose();
    txtpassword.dispose();
    txtcpassword.dispose();
    txtaadhar.dispose();
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
                controller: txtfirstname,
                decoration: const InputDecoration(
                  labelText: 'Enter Firstname:',
                  hintText: 'firstname',
                ),
                //InputDecoration
                autocorrect: true,
                onChanged: (value) {
                  firstname = value;
                },
                keyboardType: TextInputType.text,
              ), //TextField
              TextField(
                controller: txtlastname,
                decoration: const InputDecoration(
                  labelText: 'Enter Lastname:',
                  hintText: 'lastname',
                ),
                //InputDecoration
                autocorrect: true,
                onChanged: (value) {
                  lastname = value;
                },
                keyboardType: TextInputType.text,
              ), //TextField
              TextField(
                controller: txtemail,
                decoration: const InputDecoration(
                  labelText: 'Enter email:',
                  hintText: 'email',
                ),
                //InputDecoration
                autocorrect: false,
                onChanged: (value) {
                  email = value;
                },
                keyboardType: TextInputType.emailAddress,
              ), //TextField
              TextField(
                controller: txtaddress,
                decoration: const InputDecoration(
                  labelText: 'Enter address:',
                  hintText: 'Address',
                ),
                //InputDecoration
                autocorrect: false,
                onChanged: (value) {
                  address = value;
                },
                keyboardType: TextInputType.text,
              ), //TextField
              TextField(
                controller: txtphno,
                decoration: const InputDecoration(
                  labelText: 'Enter Contact no:',
                  hintText: 'PH.No',
                ),
                //InputDecoration
                autocorrect: true,
                onChanged: (value) {
                  phno = value;
                },
                keyboardType: TextInputType.number,
              ), //TextField
              TextField(
                controller: txtaadhar,
                decoration: const InputDecoration(
                  labelText: 'Enter Aadhar no:',
                  hintText: 'Aadhar no.',
                ),
                //InputDecoration
                autocorrect: false,
                onChanged: (value) {
                  aadhar = value;
                },
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: txtaaphar,
                decoration: const InputDecoration(
                  labelText: 'Enter Aaphar no:',
                  hintText: 'Aaphar no.',
                ),
                //InputDecoration
                autocorrect: false,
                onChanged: (value) {
                  aaphar = value;
                },
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: txtintern,
                decoration: const InputDecoration(
                  labelText: 'Enter Intern Domain:',
                  hintText: 'Intern domain',
                ),
                //InputDecoration
                autocorrect: false,
                onChanged: (value) {
                  intern = value;
                },
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: txtimplant,
                decoration: const InputDecoration(
                  labelText: 'Enter Implant Training Domain:',
                  hintText: 'Implant Training Domain',
                ),
                //InputDecoration
                autocorrect: false,
                onChanged: (value) {
                  implant = value;
                },
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: txtaoi,
                decoration: const InputDecoration(
                  labelText: 'Enter Area Of Interest:',
                  hintText: 'Area of Interest',
                ),
                //InputDecoration
                autocorrect: false,
                onChanged: (value) {
                  aoi = value;
                },
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: txtpassword,
                decoration: const InputDecoration(
                  labelText: 'Enter Password:',
                  hintText: 'Password',
                ),
                //InputDecoration
                autocorrect: false,
                onChanged: (value) {
                  password = value;
                },
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: txtcpassword,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password:',
                  hintText: 'Password',
                ),
                //InputDecoration
                autocorrect: false,
                onChanged: (value) {
                  cpassword = value;
                },
                keyboardType: TextInputType.text,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final snapshot = await FirebaseFirestore.instance.collection('depository').where('Aaphar', isEqualTo: aaphar).get();
                        final academicDetails = snapshot.docs[0] as Map<String, dynamic>;
                        sslcMark = academicDetails['sslcMark'];
                        hslcMark = academicDetails['hslcMark'];
                        cid = academicDetails['cid'];
                        cgpa = academicDetails['cgpa'];
                        yop1 = academicDetails['yop1'];
                        yop2 = academicDetails['yop2'];
                        yop3 = academicDetails['yop3'];
                        _showDialog(context, "Verified SuccessFully");
                      } catch (e) {
                        _showDialog(context, "Check Aaphar number");
                        if (kDebugMode) {
                          print(e);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        textStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
                        shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                        shadowColor: Colors.blueGrey),
                    child: const Text("Verify",style: TextStyle(color: Colors.white),),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        textStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
                        shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                        shadowColor: Colors.blueGrey),
                    child: const Text("register/submit",style: TextStyle(color: Colors.white),),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: email,
                            password: password).then((currentUser) =>
                            FirebaseFirestore.instance.collection("ArtsStudent")
                                .doc(currentUser.user?.uid).set({
                              "uid": currentUser.user?.uid,
                              "firstname": firstname,
                              "lastname": lastname,
                              "email": email,
                              "address": address,
                              "phno": phno,
                              "yop1": yop1,
                              "HSLC": hslcMark,
                              "SSLC": sslcMark,
                              "yop2": yop2,
                              "CID": cid,
                              "CGPA":cgpa,
                              "yop3": yop3,
                              "intern": intern,
                              "implant": implant,
                              "AOI":aoi,
                              "password": password,
                              "cpassword": cpassword,
                            }).then((result) =>
                            {FirebaseAuth.instance.signOut().then((result) =>
                            {
                              Navigator.pop(context),
                              _showDialog(context, "database connected"),
                            }).catchError(
                                    (err) => print(err)),}).catchError((err) =>
                                print(err)));
                      } catch (e) {
                        if (kDebugMode) {
                          print(e);
                        }
                      }
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        textStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
                        shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                        shadowColor: Colors.blueGrey),
                    onPressed: () {
                      txtfirstname.clear();
                      txtlastname.clear();
                      txtemail.clear();
                      txtaddress.clear();
                      txtphno.clear();
                      txtintern.clear();
                      txtimplant.clear();
                      txtpassword.clear();
                      txtaoi.clear();
                      txtcpassword.clear();
                    },
                    child: const Text("Clear",style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
