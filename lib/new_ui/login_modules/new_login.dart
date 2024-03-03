import 'package:flutter/material.dart';
import 'package:main_project1/logins/adminlogin.dart';

void main() {
  runApp(NewLoginPage());
}

class NewLoginPage extends StatefulWidget {
  @override
  _NewLoginPageState createState() => _NewLoginPageState();
}

class _NewLoginPageState extends State<NewLoginPage> {
  int _selectedIndex = 0;
  List<String> _gifs = [
    'assets/student_login.gif', // Replace with actual paths to GIFs
    'assets/firm_login.gif', // Replace with actual paths to GIFs
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      home: Scaffold(
        appBar: AppBar(
          title: Text('OPSV-Login'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminLogin()),
                );
              },
              icon: Icon(Icons.admin_panel_settings),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 100),
            Container(
              child: Image.asset(_gifs[_selectedIndex]),
              height: 200,
              width: double.infinity,
            ),
            _selectedIndex == 0
                ? Text(
                    "Student Login",
                    style: defaultTextStyle(),
                  )
                : Text(
                    "Firms Login",
                    style: defaultTextStyle(),
                  ),
            SizedBox(height: 10),
            Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black, width: 2),
                          ),
                        ),
                        child: TabBar(
                          onTap: (value) {
                            setState(() {
                              _selectedIndex = value;
                            });
                          },
                          tabs: const [
                            Tab(text: 'Student'),
                            Tab(text: 'Firms'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.black, width: 2),
                            ),
                          ),
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              StudentLoginPage(),
                              FirmsLoginPage(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle defaultTextStyle() {
    return const TextStyle(fontWeight: FontWeight.bold, fontSize: 24);
  }
}

class StudentLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const Text(
          //   'Student Login',
          //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          // ),
          SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter your username',
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Add your login logic here
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}

class FirmsLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(
          //   'Firms Login',
          //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          // ),
          SizedBox(height: 20),
          const Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter your username',
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Add your login logic here
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}

class AdminLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
      ),
      body: Center(
        child: Text('Admin Login Page'),
      ),
    );
  }
}
