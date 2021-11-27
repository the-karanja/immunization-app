// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:immunization/screens/vaccines.dart';

class Reminders extends StatelessWidget {
  // text editing controllers
  TextEditingController To = TextEditingController();
  TextEditingController from = TextEditingController();
  TextEditingController Message= TextEditingController();
  // TextEditingController Date = TextEditingController();
  // TextEditingController Doctor = TextEditingController();
  // TextEditingController comments = TextEditingController();
  Reminders({Key? key}) : super(key: key);
  //check for user

  // ignore: empty_constructor_bodie
  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Reminder"),
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
                      Icons.notification_add_outlined,
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
                  left: 15.0, right: 15.0, top: 0, bottom: 10.0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: To,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'To',
                    hintText: 'Parent@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 0, bottom: 10.0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: from,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'From',
                    hintText: 'Dr Joe'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                maxLines: 5,
                controller: Message,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Type in a Reminder Messsage',
                    hintText: 'e.g Vaccination is on going right now'),
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
                onPressed: () async{
                   Email email = Email(
                    body: Message.text,
                    subject: 'Notification',
                    recipients: [To.text],
                    isHTML: false
                  );
                 await FlutterEmailSender.send(email);
                 FirebaseFirestore.instance.collection('users').where('email',isEqualTo: To.text).get().then((QuerySnapshot snapshot){
                   snapshot.docs.forEach((doc) { 
                     FirebaseFirestore.instance.collection('users').doc(doc.id).collection('notifications').add({
                       'message': Message.text
                     });
                   });
                 });
                },
                child: Text(
                  'Send reminders', 
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
