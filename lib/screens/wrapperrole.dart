import 'dart:async';

import 'package:brgyapp/screens/admin/adminhome.dart';
import 'package:brgyapp/screens/admin/adminreport.dart';
import 'package:brgyapp/screens/emailverification.dart';
import 'package:brgyapp/screens/healthcare/healthcarevalidation.dart';
import 'package:brgyapp/screens/loginscreen.dart';
import 'package:brgyapp/screens/userhome.dart';
import 'package:brgyapp/screens/wrapperBrgyID.dart';
import 'package:brgyapp/screens/wrapperauth.dart';
import 'package:brgyapp/services/authservices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WrapperRole extends StatefulWidget {
  @override
  _WrapperRoleState createState() => _WrapperRoleState();
}

class _WrapperRoleState extends State<WrapperRole> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3F5856),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .snapshots(),
          builder: (conext, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            final userData = snapshot.data.data();
            if (userData['role'] == 'admin') {
              return AdminHomeScreen();
            } else if (userData['role'] == 'healthcare') {
              return HealthCareScreen();
            } else if (userData['role'] == 'resident') {
              return WrapperBrgyID();
            }
            return LoginScreen();
          }),
    );
  }
}
