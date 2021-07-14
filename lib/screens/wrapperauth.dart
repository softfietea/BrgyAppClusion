import 'package:brgyapp/screens/emailverification.dart';
import 'package:brgyapp/screens/loginscreen.dart';
import 'package:brgyapp/screens/userhome.dart';
import 'package:brgyapp/screens/wrapperrole.dart';
import 'package:brgyapp/services/authservices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WrapperAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null && firebaseUser.emailVerified == true) {
      return WrapperRole();
    } else if (firebaseUser != null && firebaseUser.emailVerified == false) {
      context.read<AuthService>().userVerified;
      return EmailVerificationScreen();
    }
    return LoginScreen();
  }
}
