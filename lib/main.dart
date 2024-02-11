import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:main_project1/forget_password_screen.dart';
import 'package:main_project1/logins/MBAlogin.dart';
import 'package:main_project1/logins/arts_student_login.dart';
import 'package:main_project1/querypage.dart';

import 'logindivision.dart';
import 'logins/adminlogin.dart';
import 'logins/userlogin.dart';

Future<void> main() async {
  bool isTesting = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent)),
    home: isTesting ? ArtsStudentLogin() : Splash(),
  ));
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: FlutterSplashScreen(
          splashScreenBody: Center(
            child: Image.asset("assets/splashscreen.jpeg"),
          ),
          nextScreen: const MyApp(),
          backgroundColor: Colors.white,
          duration: const Duration(milliseconds: 3000),
          onInit: () async {
            await Future.delayed(const Duration(milliseconds: 2000));
          },
          onEnd: () async {},
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OPSV"),
        leading: IconButton(
          icon: const Icon(Icons.query_builder),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const QueryPage()));
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person_pin),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminLogin()));
            },
          )
        ],
      ),
      bottomSheet: Container(
        height: 130,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.person_pin),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginDivision()));
                    },
                    iconSize: 60.0,
                    color: Colors.green,
                  ),
                  Container(
                    color: Colors.transparent,
                    child: const Text(
                      "Student",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.business_rounded),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const UserLogin()));
                    },
                    iconSize: 60.0,
                    color: Colors.orange,
                  ),
                  Container(
                    color: Colors.transparent,
                    child: const Text(
                      "Firms",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Container(
            color: Colors.transparent,
            width: double.infinity,
            height: 135,
            child: Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Welcome',
                    textStyle: const TextStyle(
                      fontSize: 50.0,
                      fontFamily: 'Horizon',
                    ),
                    colors: [
                      Colors.purple,
                      Colors.blue,
                      Colors.yellow,
                      Colors.red,
                    ],
                  )
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            width: double.infinity,
            height: 135,
            child: Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'To',
                    textStyle: const TextStyle(
                      fontSize: 50.0,
                      fontFamily: 'Horizon',
                    ),
                    colors: [
                      Colors.purple,
                      Colors.blue,
                      Colors.yellow,
                      Colors.red,
                    ],
                  )
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            width: double.infinity,
            height: 135,
            child: Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'OPSV',
                    textStyle: const TextStyle(
                      fontSize: 50.0,
                      fontFamily: 'Horizon',
                    ),
                    colors: [
                      Colors.purple,
                      Colors.blue,
                      Colors.yellow,
                      Colors.red,
                    ],
                  )
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
              ),
            ),
          ),
          SizedBox(
            height: 100,
          )
        ]),
      ),
    );
  }
}
