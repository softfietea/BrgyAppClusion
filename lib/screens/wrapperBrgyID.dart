import 'package:brgyapp/screens/brgyIDVerification.dart';
import 'package:brgyapp/screens/loginscreen.dart';
import 'package:brgyapp/screens/userhome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WrapperBrgyID extends StatefulWidget {
  @override
  _WrapperBrgyIDState createState() => _WrapperBrgyIDState();
}

class _WrapperBrgyIDState extends State<WrapperBrgyID> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (conext, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final userData = snapshot.data.data();
          if (userData['brgyIDValidated'] == 'no') {
            return BrgyIDVerificationScreen();
          }
          if (userData['brgyIDValidated'] == 'yes') {
            return UserHomeScreen();
          }
          return LoginScreen();
        });
  }
}
