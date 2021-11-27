// ignore: unused_import
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';


class ParentsPage extends StatefulWidget{
  const ParentsPage({Key? key}) : super(key: key);
  
  @override
  State<ParentsPage> createState() => ParentsState();
}


class ParentsState extends State<ParentsPage>{
  
  @override
  final themecolor = Colors.blueAccent;
  Widget build(BuildContext context) {
     FirebaseAuth.instance.authStateChanges().listen((User? user) { 
      if (user == null){

      } else {
        Navigator.pushNamed(context, '/login');
      }
    });
    final stream = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('vaccines').where('email',isEqualTo: FirebaseAuth.instance.currentUser!.email).snapshots();
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Welcome"),
                centerTitle: true,
                actions: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/parentsNotifications');
                      },
                      child: Icon(
                        Icons.supervised_user_circle,
                        size: 40.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                ],
              ),
              body: Center(
                child: Text("something went wrong"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Welcome"),
                centerTitle: true,
                actions: <Widget>[
                  const Icon(Icons.notification_add),
                  // SizedBox(width:10.0),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/parentsNotifications');
                      },
                      child: Icon(
                        Icons.notification_add,
                        size: 40.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                ],
              ),
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              ),
            );
          }
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
                    Divider(
                      thickness: 1.5,
                      endIndent: 4.0,
                    ),
                    SizedBox(
                      height: 250,
                    ),
                    ListTile(
                        leading: FloatingActionButton(
                          onPressed: () {
                          FirebaseAuth.instance.signOut();
                            Navigator.pushNamed(context, '/login');
                          },
                          backgroundColor: themecolor,
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
              actions: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/parentsNotifications');
                    },
                    child: Icon(
                      Icons.notification_important,
                      size: 40.0,
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
              ],

              // Title
              centerTitle: true,
              title: Title(
                color: Colors.black,
                child: const Text("Notifications"),
              ),
            ),
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                DataTable(
                  columns: [
                    DataColumn(label: Text("Vaccine")),
                    DataColumn(label: Text("Date")),
                    DataColumn(label: Text("Doctor")),
                    DataColumn(label: Text("status"))
                  ],
                  rows: _buildList(context, snapshot.data!.docs),
                ),
              ],
            ),

            // bottom Floating Action Button
            
          );
      },
    );
  }
}
List<DataRow> _buildList(
    BuildContext context, List<DocumentSnapshot> snapshot) {
  return snapshot.map((data) => _buildItems(context, data)).toList();
}

DataRow _buildItems(BuildContext context, DocumentSnapshot data) {
  return DataRow(
    cells: [
      DataCell(Text(data['vaccine']), onTap: () {
       
      }),
      DataCell(
        Text(
          data['date'],
        ),
        placeholder: true,
      ),
      DataCell(Text(data['doctor'])),
      DataCell(Text(data['status'])),
    ],
  );
}