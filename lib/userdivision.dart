import 'package:flutter/material.dart';
import 'firms/MBAfirm.dart';
import 'firms/engineerfirm.dart';
import 'firms/firm.dart';

class userdivision extends StatefulWidget {
  const userdivision({Key? key}) : super(key: key);

  @override
  State<userdivision> createState() => _userdivisionState();
}

class _userdivisionState extends State<userdivision> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('OPSV-Division',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color : Colors.white,
            fontSize: 15.0,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height:double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://img.wallpapersafari.com/desktop/1366/768/2/3/QLI4V2.png"),
                fit: BoxFit.cover)),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[Column(
            children: <Widget>[
              Container(
                child: ElevatedButton(
                    child: Text("Arts student",style:TextStyle(
                      fontSize:30.0,
                      fontWeight: FontWeight.bold,
                    ),
                      textAlign: TextAlign.center,),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2)))
                        ,
                        shadowColor: Colors.blueGrey),
                    onPressed:() {
                      Navigator.push(
                          context,MaterialPageRoute(builder:(context)=>firm()));
                    }
                ),
                width:double.infinity,
                height: 100,
                padding: EdgeInsets.all(10),
              ),
            ],
          ),
            Column(
              children: <Widget>[

                Container(
                  child: ElevatedButton(
                      child: Text("Engineering Student",style:TextStyle(
                        fontSize:30.0,
                        fontWeight: FontWeight.bold,
                      ),
                        textAlign: TextAlign.center,),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(2))),
                          shadowColor: Colors.blueGrey),
                      onPressed:() {
                        Navigator.push(
                            context,MaterialPageRoute(builder:(context)=>engineerfirm()));
                      }
                  ),
                  width:double.infinity,
                  height: 100,
                  padding: EdgeInsets.all(10),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  child: ElevatedButton(
                      child: Text("MBA Student",style:TextStyle(
                        fontSize:30.0,
                        fontWeight: FontWeight.bold,
                      ),
                        textAlign: TextAlign.center,),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(2))),
                          shadowColor: Colors.blueGrey),
                      onPressed:() {
                        Navigator.push(
                            context,MaterialPageRoute(builder:(context)=>MBAfirm()));
                      }
                  ),
                  width:double.infinity,
                  height: 100,
                  padding: EdgeInsets.all(10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}