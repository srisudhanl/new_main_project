import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../pages/engineer.dart';
import '../querypage.dart';
import '../registers/engineeringregister.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EngineeringLogin extends StatefulWidget {
  const EngineeringLogin({Key? key}) : super(key: key);

  @override
  State<EngineeringLogin> createState() => _EngineeringLoginState();
}

class _EngineeringLoginState extends State<EngineeringLogin> {
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  void initState(){
    super.initState();}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: const Text('OPSV- Engineering Login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.query_builder),
              onPressed: (){
                Navigator.push(
                    context,MaterialPageRoute(builder:(context)=>const QueryPage()));
              },
            ),
          ],//TextStyle
        ),
        body:Container(
          width: double.infinity,
          height:double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.jpeg"),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
              child:Column(
                  children:<Widget>[
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/engineering_login.jpeg"),
                              fit: BoxFit.cover)),
                    ),
                    const Text('Engineer Login',
                      style: TextStyle(
                        fontWeight:FontWeight.bold,
                        fontSize: 35.0,
                      ),//TextStyle
                    ),//Text
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration:const InputDecoration(
                          labelText:'Enter Email:',
                          hintText:'email address',
                        ),//InputDecoration
                        autocorrect:false,
                        keyboardType:TextInputType.emailAddress,
                        onChanged: (value){email=value;},
                      ),
                    ),
                    Container(
                      color:Colors.transparent,
                      height: 30,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        obscureText: true,
                        decoration:const InputDecoration(
                          labelText:'Enter PassWord:',
                          hintText:'Password',
                        ),//InputDecoration
                        autocorrect:false,
                        keyboardType:TextInputType.text,
                        onChanged: (value){password=value;},
                      ),
                    ),
                    Container(
                      color:Colors.transparent,
                      height: 50,
                      width: double.infinity,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  textStyle: const TextStyle(
                                      color: Colors.white, fontSize: 15.0
                                  ),
                                  shape: const BeveledRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(2))),
                                  shadowColor: Colors.blueGrey),
                              onPressed:()async{
                                setState((){showSpinner = true;});
                                try{
                                  final user = await FirebaseAuth.instance.signInWithEmailAndPassword(email:email,password:password).then((currentUser) =>
                                      FirebaseFirestore.instance.collection("engineer"));
                                  if(user!= null){
                                  Navigator.push(
                                      context,MaterialPageRoute(builder:(context)=>const engineer())
                                  );}}
                                catch(e){if (kDebugMode) {
                                  print(e);
                                }}
                                setState((){showSpinner = false;});},
                              child: const Text("Login",style: TextStyle(color: Colors.white))
                          ),
                          ElevatedButton(onPressed: (){
                            Navigator.push(
                                context,MaterialPageRoute(builder:(context)=>const EngineeringLogin()));
                          },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                textStyle:
                                const TextStyle(color: Colors.white, fontSize: 15.0),
                                shape: const BeveledRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                                shadowColor: Colors.blueGrey),
                            child: const Text("Cancel",style: TextStyle(color: Colors.white)),)
                        ]
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            const Text("Don't Have an Account!!",
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
                                    shadowColor: Colors.redAccent
                                ),
                                onPressed: (){
                                  Navigator.push(
                                      context,MaterialPageRoute(builder:(context)=>const EngineeringRegister()));
                                },
                                child: const Text(
                                    "Sign Up",style: TextStyle(color: Colors.white)
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ]
              )
          ),
        )
    );
  }
}