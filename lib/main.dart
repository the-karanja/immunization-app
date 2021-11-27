// ignore_for_file: prefer_const_constructors



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:immunization/screens/doctorStats.dart';
import 'package:immunization/screens/notifications.dart';
import 'package:immunization/screens/reminders.dart';

import './register.dart';
import './home.dart';
import './screens/vaccines.dart';
import './screens/add_child.dart';
import './screens/immunize.dart';
import './screens/parentsHome.dart';
import './screens/profile.dart';
import './screens/doctorStats.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => LoginDemo(),
        '/register': (context) => RegisterDemo(),
        '/home': (context) => MyHomePage(
              title: 'Home',
            ),
        '/vaccines': (context) => ShowVaccines(),
        '/addChild': (context) => AddChild(),
        '/immunize': (context) => Immunize(),
        '/notify': (context) => Notifications(),
        '/parents': (context) => ParentsPage(),
        '/stats': (context) => DoctorsPage(),
        '/parentsNotifications': (context) => NotificationsPage(),
        '/reminders': (context) => Reminders()
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
      ),
      home: const LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  const LoginDemo({Key? key}) : super(key: key);

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  FirebaseAuth auth = FirebaseAuth.instance;
  // form key
  final _formKey = GlobalKey<FormState>();

  // text editing controllers
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  //check for user

  // ignore: empty_constructor_bodie
  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text("Welcome Back"),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Center(
                    child: Container(
                        width: 200,
                        height: 150,
                        /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                        child: const Icon(
                          Icons.lock,
                          color: Colors.purple,
                          size: 150.0,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0)
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                  ),
                ),
               MaterialButton(
                  onPressed: () {
                    //TODO FORGOT PASSWORD SCREEN GOES HERE
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(20)),
                  child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () {
                      if (email.text == '') {
                        scaffold.showSnackBar(SnackBar(
                            backgroundColor: Colors.blue,
                            content: const Text('Enter an Email')));
                      } else if (password.text == '') {
                        scaffold.showSnackBar(SnackBar(
                            content: const Text('Enter a Password'),
                            backgroundColor: Colors.purple));
                      } else {
                        try {
                          FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text).then((value){
                            FirebaseFirestore.instance.collection('users').where('email',isEqualTo: email.text).get().then((QuerySnapshot snapshot){
                            snapshot.docs.forEach((doc) { 
                              String role = doc['role'];
                              if (role == 'parent') {
                                Navigator.of(context).pushNamed('/parents');
                              } else if(role == 'doctor'){
                                Navigator.of(context).pushNamed('/home');
                              }
                            });
                          });
                          });
                          
                          // FirebaseAuth.instance
                          //     .signInWithEmailAndPassword(
                          //         email: email.text, password: password.text)
                          //     .then((value) {
                          //       Navigator.pushNamed(context, '/home');
                          //   // FirebaseFirestore.instance
                          //   //     .collection('users')
                          //   //     .doc('0XPLG74e7aRFARJ4N7BduV7Yk6a2')
                          //   //     .get()
                          //   //     .then((DocumentSnapshot snapshot) {
                          //   //      print(snapshot.get('role'));
                          //   //     });
                          // });
                        } on FirebaseAuthException catch (e) {
                          AlertDialog(
                            title: Text('vccc'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e.message')));
                          print(e.message);
                        }
                        // try {
                        //   FirebaseAuth.instance
                        //       .signInWithEmailAndPassword(
                        //           email: email.text, password: password.text)
                        //       .then((value) =>
                        //       Navigator.pushNamed(context, '/home')
                        //       );
                        // } on FirebaseAuthException catch (e) {
                        //   if (e.code == "Firebase_auth/user-not-found") {
                        //     // scaffold.showSnackBar(SnackBar(
                        //     //   content:
                        //     //       const Text('No user Found with that email'),
                        //     //   backgroundColor: Colors.blue,
                        //     // ));
                        //     print("user-not-found");
                        //   } else {
                        //     scaffold.showSnackBar(SnackBar(
                        //       content: const Text('wrong Password'),
                        //       backgroundColor: Colors.purple,
                        //     ));
                        //   }
                      }
                    },
                    child: Text(
                      'Login As A Doctor',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                   
                ),
                Divider(),
                MaterialButton(onPressed:(){
                  if(email.text == '' && password.text == ''){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("fill in all the fields")));
                  } else {
                     FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text).then((value){
                            FirebaseFirestore.instance.collection('users').where('email',isEqualTo: email.text).get().then((QuerySnapshot snapshot){
                            snapshot.docs.forEach((doc) { 
                              String role = doc['role'];
                              if (role == 'parent') {
                                Navigator.of(context).pushNamed('/parents');
                              } else if(role == 'doctor'){
                                Navigator.of(context).pushNamed('/home');
                              }
                            });
                          });
                          });
                  }
                },
                child: Text('Login As A Parent'),
                color: Colors.blue,
                ),
                SizedBox(
                  height: 40,
                ),
                MaterialButton(
                    child: Text(
                      'Register A Doctor',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    }),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }
}
