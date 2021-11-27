// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _authenticated = false;

  var label;

  void _increment() {
    setState(() {
      _counter++;
      print('$_counter');
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String username = '';
    // FirebaseAuth.instance.authStateChanges().listen((User? user) { 
    //   if (user == null){

    //   } else {
    //     Navigator.pushNamed(context, '/login');
    //   }
    // });
    const themecolor = Colors.purple;
    Padding(padding: EdgeInsets.all(20.0));
    return Scaffold(
      drawer: Drawer(
        child: Center(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: themecolor,
                ),
                child: Text("Hello"),
              ),
             
              // ListTile(
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              //   leading: const Icon(
              //     Icons.verified_user_rounded,
              //     color: Colors.purple,
              //   ),
              //   title: Text(
              //     "Doctors Profile",
              //     style: TextStyle(fontSize: 16),
              //   ),
              // ),
              Divider(
                thickness: 1.5,
                endIndent: 4.0,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed('/stats');
                },
                leading: const Icon(
                  Icons.format_list_numbered_outlined,
                  color: Colors.purple,
                ),
                title: Text(
                  "Reports",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Divider(
                thickness: 1.5,
                endIndent: 4.0,
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: const Icon(
                  Icons.lock,
                  color: Colors.purple,
                ),
                title: Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Divider(
                thickness: 1.5,
                endIndent: 4.0,
              ),
              SizedBox(
                height: 100,
              ),
              ListTile(
                  leading: FloatingActionButton(
                    onPressed: () {
                      auth.signOut();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("logged out")));
                      Navigator.pushNamed(context, '/login');
                    },
                    backgroundColor: Colors.purple,
                    child: Icon(Icons.logout),
                  ),
                  title: Text(
                    "logout",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 16),
                  ))
            ],
          ),
        ),
      ),
      appBar: AppBar(
        // actions
        actions: const <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Text("Bk"),
          ),
          SizedBox(width: 10.0),
        ],

        // Title
        centerTitle: true,
        title: Title(
          color: Colors.black,
          child: const Text("Vaccination"),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 5.0),
        child: Column(children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Card(
                elevation: 10.0,
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/addChild');
                  },
                  leading: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Add Child",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  subtitle: Text(
                    'Register Child',
                    style: TextStyle(color: Colors.white),
                  ),
                  isThreeLine: false,
                  trailing: Icon(
                    Icons.supervised_user_circle_outlined,
                    color: Colors.white,
                  ),
                  tileColor: Colors.indigoAccent,
                ),
              ),
              SizedBox(height: 20.0),
              Card(
                elevation: 10.0,
                child: ListTile(
                  onTap: (){
                    Navigator.pushNamed(context, '/notify');
                  },
                  leading: Icon(
                    Icons.notification_add,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Send Notifications",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  subtitle: Text(
                    'Create Vaccinations Awareness',
                    style: TextStyle(color: Colors.white),
                  ),
                  isThreeLine: false,
                  trailing: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  tileColor: Colors.indigoAccent,
                ),
              ),
              SizedBox(height: 20.0),
              Card(
                elevation: 10.0,
                child: ListTile(
                  onTap: (){
                    Navigator.pushNamed(context, '/stats');
                  },
                  leading:
                      Icon(Icons.file_present_rounded, color: Colors.white),
                  title: Text(
                    "View Records",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  subtitle: Text(
                    'View  Vaccination records',
                    style: TextStyle(color: Colors.white),
                  ),
                  isThreeLine: false,
                  trailing: Icon(Icons.remove_red_eye, color: Colors.white),
                  tileColor: Colors.indigoAccent,
                ),
              ),
              SizedBox(height: 20.0),
              Card(
                elevation: 10.0,
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/reminders');
                  },
                  leading: Icon(Icons.health_and_safety, color: Colors.white),
                  title: Text(
                    "Send Reminders",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  subtitle: Text(
                    'Remind Parents about upcoming Vaccines',
                    style: TextStyle(color: Colors.white),
                  ),
                  isThreeLine: false,
                  tileColor: Colors.indigoAccent,
                ),
              ),
              SizedBox(height: 20.0),
              Card(
                elevation: 10.0,
                child: ListTile(
                  onTap: (){
                    Navigator.pushNamed(context, '/immunize');
                  },
                  leading: Icon(Icons.baby_changing_station_sharp,
                      color: Colors.white),
                  title: Text(
                    "Immunize",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  subtitle: Text(
                    'Add An imunizarion record',
                    style: TextStyle(color: Colors.white),
                  ),
                  isThreeLine: false,
                  trailing:
                      Icon(Icons.format_list_numbered, color: Colors.white),
                  tileColor: Colors.indigoAccent,
                ),
              ),
            ],
          ),
        ]),
      ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
