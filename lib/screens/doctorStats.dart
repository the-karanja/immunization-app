// ignore: unused_import
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';


class DoctorsPage extends StatefulWidget{
  const DoctorsPage({Key? key}) : super(key: key);
  
  @override
  State<DoctorsPage> createState() => DoctorsState();
}


class DoctorsState extends State<DoctorsPage>{
  @override
  final themecolor = Colors.blueAccent;
  Widget build(BuildContext context) {
    final stream = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('stats').snapshots();
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
                        Navigator.pushNamed(context, '/profile');
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
                title: Text("View Records"),
                centerTitle: true,
                actions: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
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
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      dense: true,
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(80),
                      //   side: BorderSide(color: Colors.black)
                      //   ),
                      leading: Icon(
                        Icons.notification_add,
                        color: themecolor,
                      ),
                      title: const Text(
                      "Notifications",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                        ),
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
                      leading: Icon(
                        Icons.language,
                        color: themecolor,
                      ),
                      title: Text(
                        "Choose Language",
                        style: TextStyle(fontSize: 16),
                      ),
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
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: Icon(
                      Icons.supervised_user_circle,
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
                child: const Text("Records"),
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
                    DataColumn(label: Text("childName")),
                    DataColumn(label: Text("date")),
                    DataColumn(label: Text("vaccine")),
                    // DataColumn(label: Text("status"))
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
      DataCell(Text(data['childName']), onTap: () {
        Navigator.pushNamed(context, '/TeamStats', arguments: data['Name']);
      }),
      DataCell(
        Text(
          data['date'],
        ),
        placeholder: true,
      ),
      DataCell(Text(data['vaccine'])),
      // DataCell(Text(data['status'])),
    ],
  );
}