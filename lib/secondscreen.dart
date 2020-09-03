import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String username;
  String gender;
  int age;
  String uid;
  final firestore = Firestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    inputData();
    super.initState();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  void inputData() async {
    FirebaseAuth.instance.onAuthStateChanged.listen((user) => {
          if (user != null) {uid = user.uid}
        });
    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please Enter the Information Below',
              style: TextStyle(fontSize: 20),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username',
                ),
                onChanged: (value) {
                  username = value;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Age',
                ),
                onChanged: (value) {
                  age = int.parse(value);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Gender',
                ),
                onChanged: (value) {
                  gender = value;
                },
              ),
            ),
            RaisedButton.icon(
              color: Colors.deepOrangeAccent,
              onPressed: () {
                firestore.collection('users').document(uid).setData({
                  'username': username,
                  'gender': gender,
                  'age': age,
                });
              },
              icon: Icon(
                Icons.arrow_forward,
              ),
              label: Text(
                'Submit',
                style: TextStyle(fontSize: 20),
              ),
            ),
            // RaisedButton(onPressed: () async {
            //   // await _firebaseAuth.signOut();
            // })
          ],
        ),
      ),
    );
  }
}
