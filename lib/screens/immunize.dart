// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:immunization/screens/vaccines.dart';

class Immunize extends StatelessWidget {
  // text editing controllers
  TextEditingController name = TextEditingController();
  TextEditingController CertificateNo = TextEditingController();
  TextEditingController Vaccine = TextEditingController();
  TextEditingController Date = TextEditingController();
  TextEditingController Doctor = TextEditingController();
  TextEditingController comments = TextEditingController();
  TextEditingController childsName = TextEditingController();
  Immunize({Key? key}) : super(key: key);
  //check for user

  // ignore: empty_constructor_bodie
  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser!.email);
    final scaffold = ScaffoldMessenger.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Record Immunizations Here"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 100,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: const Icon(
                      Icons.supervised_user_circle_rounded,
                      color: Colors.purple,
                      size: 60.0,
                    )),
              ),
            ),
            // const SizedBox(
            //   height: 10.0,
            // ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 0, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: Doctor,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Doctors Name',
                    hintText: 'Dr Joe'),
              ),
            ),
          
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10.0, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: CertificateNo,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Parents email',
                    hintText: 'E.g bcaranja@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10.0, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: childsName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'childs Name',
                    hintText: 'brian'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 10),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: Vaccine,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Vaccine Name',
                    hintText: 'BCG'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:10.0,bottom: 0),
         
              child: TextField(
                controller: Date,
                decoration: InputDecoration(
                    // ignore: prefer_const_constructors
                    border: OutlineInputBorder(),
                    labelText: 'Date of immunization',
                    hintText: '10/10/2020'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:10.0,bottom: 0),

              child: TextField(
                maxLines: 5,
                controller: comments,
                decoration: InputDecoration(
                    // ignore: prefer_const_constructors
                    border: OutlineInputBorder(),
                    labelText: 'Doctors Comments',
                    hintText: 'Child Should feed more to grow'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  String name = '';
                  FirebaseFirestore.instance.collection('users').where('email',isEqualTo: CertificateNo.text).get().then((QuerySnapshot querySnapshot){
                    querySnapshot.docs.forEach((doc) {
                      print(doc['email']);
                      FirebaseFirestore.instance.collection('users').doc(doc.id).collection('vaccines').add({
                        'vaccine': Vaccine.text,
                        'date': Date.text,
                        'comments': comments.text,
                        'email': CertificateNo.text,
                        'status': 'immunized',
                        'doctor': Doctor.text,
                      }).then((value){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Immunization record added successfully")));
                      });
                     });
                  });

                  FirebaseFirestore.instance.collection('users').where('email',isEqualTo: FirebaseAuth.instance.currentUser!.email).get().then((QuerySnapshot querySnapshot){
                    querySnapshot.docs.forEach((doc) { 
                      FirebaseFirestore.instance.collection('users').doc(doc.id).collection('stats').add({
                        'vaccine': Vaccine.text,
                        'date': Date.text,
                        'childName': childsName.text,
                      });
                    });
                  });
                },
                child: Row(
                  children: const [    
                    SizedBox(width:30.0),           
                     Text(
                  'Vaccinate & Save',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                SizedBox(width: 20.0,),
                Icon(Icons.check_circle_outline_sharp)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
