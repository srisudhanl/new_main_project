import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MbaRegister extends StatefulWidget {
  const MbaRegister({Key? key}) : super(key: key);

  @override
  State<MbaRegister> createState() => _MbaRegisterState();
}

class _MbaRegisterState extends State<MbaRegister> {
  late String firstname, lastname, email, address;
  late String phno, aadhar, apaarNumber, password;
  late String cpassword, intern, implant, aoi;
  late String sslcMark, hscMark, cgpa, cid;
  late String yop1, yop2, yop3;
  bool isVerified = false;

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
  final txtapaar = TextEditingController();
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
    txtapaar.dispose();
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
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
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
              ),
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
              ), //TextField
              TextField(
                controller: txtapaar,
                decoration: InputDecoration(
                  labelText: 'Enter Aaphar no:',
                  hintText: 'Aaphar no.',
                  suffixIcon: IconButton(
                    onPressed: () {
                      launchUrlToBrowser("https://www.abc.gov.in/");
                    },
                    icon: Icon(Icons.report_outlined),
                  ),
                ),
                //InputDecoration
                autocorrect: false,
                onChanged: (value) {
                  apaarNumber = value;
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          final snapshot = await FirebaseFirestore.instance.collection('depository').where('apaar number', isEqualTo: apaarNumber).get();
                          final academicDetails = snapshot.docs[0] as DocumentSnapshot;
                          sslcMark = academicDetails['sslc'];
                          hscMark = academicDetails['hsc'];
                          cid = academicDetails['cid'];
                          cgpa = academicDetails['cgpa'];
                          yop1 = academicDetails['yop1'];
                          yop2 = academicDetails['yop2'];
                          yop3 = academicDetails['yop3'];
                          _showDialog(context, "Verified SuccessFully");
                          isVerified = true;
                          refresh();
                        } catch (e) {
                          _showDialog(context, "Check Apaar number");
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
                      onPressed: isVerified?() async {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: email,
                              password: password).then((currentUser) =>
                              FirebaseFirestore.instance.collection("MbaStudent")
                                  .doc(currentUser.user?.uid).set({
                                "uid": currentUser.user?.uid,
                                "firstname": firstname,
                                "lastname": lastname,
                                "email": email,
                                "address": address,
                                "phno": phno,
                                "yop1": yop1,
                                "HSC": hscMark,
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

                              }).catchError(
                                      (err) => print(err)),}).catchError((err) =>
                                  print(err)));
                        } catch (e) {
                          if (kDebugMode) {
                            print(e);
                          }
                        }
                        Navigator.pop(context);
                        _showDialog(context, "data inserted successfully");
                      }:null,
                      child: const Text("register/submit",style: TextStyle(color: Colors.white),),
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
                        txtaadhar.clear();
                        txtapaar.clear();
                        txtcpassword.clear();
                      },
                      child: const Text("Clear",style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void launchUrlToBrowser(String url, {LaunchMode mode = LaunchMode.externalApplication}) async {
    try {
      Uri? uri = Uri.tryParse(url);
      if (uri != null) {
        launchUrl(uri);
      } else {
        print('URI cannot be null.');
      }
    } catch (e) {
      print( 'Launch url error : $e');
    }
  }
  void refresh() {
    if (mounted) setState(() {});
  }
}
