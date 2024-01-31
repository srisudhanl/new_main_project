import 'package:flutter/material.dart';

import '../querypage.dart';

class engineer extends StatefulWidget {
  const engineer({Key? key}) : super(key: key);

  @override
  State<engineer> createState() => _engineerState();
}

class _engineerState extends State<engineer> {
  late String myfirstname;
  late String mylastname;
  late String myaddress;
  late String myphno;
  late String mySSLC;
  late String myyop1;
  late String myHSLC;
  late String myyop2;
  late String mydept;
  late String myCID;
  late String myyop3;
  late String myintern;
  late String myinplant;
  late String myAOI;
  late String mypassword;
  late String mycpassword;
  late String myEmail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('OVPC-Engineer',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color : Colors.white,
            fontSize: 15.0,
          ),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.query_builder),
            onPressed: (){
              Navigator.push(
                  context,MaterialPageRoute(builder:(context)=>QueryPage()));
            },
          ),
        ],//TextStyle
      ),
      body: Center(
        child: FutureBuilder(
          future: _fetch(),
          builder: (context,snapshot){
            if(snapshot.connectionState!=ConnectionState.done){
              return Text("Loading data ... Please Wait");
            }
            return SingleChildScrollView(
              child:Column(
                children: <Widget> [
                  ListTile(
                    title: Text("firstName       :myfirstname"),
                  ),
                  ListTile(
                    title: Text("lastName        :mylastname"),
                  ),
                  ListTile(
                    title: Text("email           :myEmail"),
                  ),
                  ListTile(
                    title: Text("ph.no           :myphno"),
                  ),
                  ListTile(
                    title: Text("Address         :myaddress"),
                  ),
                  ListTile(
                    title: Text("SSLC I.D        :mySSLC"),
                  ),
                  ListTile(
                    title: Text("Year of Passing :myyop1"),
                  ),
                  ListTile(
                    title: Text("HSLC I.D        :myHSLC"),
                  ),
                  ListTile(
                    title: Text("Year of Passing :myyop2"),
                  ),
                  ListTile(
                    title: Text("Department      :mydept"),
                  ),
                  ListTile(
                    title: Text("College I.D     :myCID"),
                  ),
                  ListTile(
                    title: Text("Year of Passing :myyop3"),
                  ),
                  ListTile(
                    title: Text("Internships     :myintern"),
                  ),
                  ListTile(
                    title: Text("InplantTraining :myinplant"),
                  ),
                  ListTile(
                    title: Text("Area of Interest :myAOI"),
                  ),
                  ListTile(
                    title: Text("PassWord         :mypassword"),
                  ),
                  ListTile(
                    title: Text("Confirm Password :mycpassword"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

  }
  _fetch() async{
    // final firebaseuser = await FirebaseAuth.instance.currentUser;
    // if(firebaseuser!=null){
    //   await Firestore.instance.collection('MBA').document(firebaseuser.uid).get()
    //       .then((ds){
    //     myfirstname=ds.data()['firstname'];
    //     mylastname=ds.data()['lastname'];
    //     myaddress=ds.data()['address'];
    //     myEmail=ds.data()['email'];
    //     myphno=ds.data()['phno'];
    //     mySSLC=ds.data()['SSLC'];
    //     myyop1=ds.data()['yop1'];
    //     myHSLC=ds.data()['HSLC'];
    //     myyop2=ds.data()['yop2'];
    //     mydept=ds.data()['dept'];
    //     myCID=ds.data()['CID'];
    //     myyop3=ds.data()['yop3'];
    //     myintern=ds.data()['intern'];
    //     myinplant=ds.data()['inplant'];
    //     myAOI=ds.data()['AOI'];
    //     mypassword=ds.data()['password'];
    //     mycpassword=ds.data()['cpassword'];
    //   }).catchError((e){
    //     print(e);
    //   });
    // }
  }
}