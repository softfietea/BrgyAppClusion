import 'dart:ui';

import 'package:brgyapp/model/userapp.dart';
import 'package:brgyapp/services/databaseservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<User> get authStateChanges => _auth.authStateChanges();

  User _loggedUser;

  final auth = FirebaseAuth.instance;
  User currentUser;

  /// Function to get the currently logged in user
  String getCurrentUser() {
    currentUser = auth.currentUser;
    return currentUser.uid.toString();
  }

  String getCurrentName() {
    currentUser = auth.currentUser;
    return currentUser.displayName.toString();
  }

  Future<bool> get userVerified async {
    await FirebaseAuth.instance.currentUser.reload();
    return FirebaseAuth.instance.currentUser.emailVerified;
  }

  //firebase custom user

  //sign in
  Future signIn(String signEmail, String signPassword) async {
    try {
      final signInUser = await _auth.signInWithEmailAndPassword(
          email: signEmail, password: signPassword);

      _loggedUser != null
          ? _loggedUser = signInUser.user
          : print('failed to sign in');
    } on FirebaseAuthException catch (e) {
      if (e.message == "Given String is empty or null") {
        Fluttertoast.showToast(
            textColor: Color(0xff3F5856),
            msg: "Please Input an email and password",
            backgroundColor: Color(0xffF5C69D));
      } else if (e.code == "user-not-found") {
        Fluttertoast.showToast(
            textColor: Color(0xff3F5856),
            msg: "There is no such registered user",
            backgroundColor: Color(0xffF5C69D));
      } else if (e.code == "invalid-email") {
        Fluttertoast.showToast(
            textColor: Color(0xff3F5856),
            msg: "The Email is invalid",
            backgroundColor: Color(0xffF5C69D));
      } else if (e.code == "invalid-password") {
        Fluttertoast.showToast(
            textColor: Color(0xff3F5856),
            msg: "The Password is Invalid",
            backgroundColor: Color(0xffF5C69D));
      } else if (e.code == "too-many-requests") {
        Fluttertoast.showToast(
            textColor: Color(0xff3F5856),
            msg: "Too many request please try again later",
            backgroundColor: Color(0xffF5C69D));
      } else if (e.code == "wrong-password") {
        Fluttertoast.showToast(
            textColor: Color(0xff3F5856),
            msg: "Wrong password,please input a correct password",
            backgroundColor: Color(0xffF5C69D));
      } else if (e.code == "network-request-failed") {
        Fluttertoast.showToast(
            textColor: Color(0xff3F5856),
            msg: "login Failed, check your connection",
            backgroundColor: Color(0xffF5C69D));
      } else {
        Fluttertoast.showToast(
            textColor: Color(0xff3F5856),
            msg: e.code,
            backgroundColor: Color(0xffF5C69D));
      }
    } on PlatformException catch (er) {
      print("Failed Platform Code: " + er.code);
    }
  }

  //signout
  Future signOut() async {
    await _auth.signOut();
    await _loggedUser.reload();
  }

  //sign up
  Future signUp(String rEmail, String rPassword, String rFullname) async {
    try {
      UserCredential newUser = await _auth.createUserWithEmailAndPassword(
          email: rEmail, password: rPassword);

      newUser != null ? _loggedUser = newUser.user : print('failed to signUp');

      await _loggedUser.updateDisplayName(rFullname);

      await _loggedUser.sendEmailVerification();

      await DatabaseService(uid: _loggedUser.uid)
          .updateUserData(_loggedUser.email, rFullname);
    } catch (e) {
      print(e.toString());
    }
  }

  //forgetpassword
  Future forgetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  //delete account
  Future deleteAccount() async {}

  Future makeAnAnnouncement(String title, String description) async {
    await DatabaseService(uid: "adminAnnouncementUid")
        .createAnnouncement(title, description);
  }

  Future makeAReport(String report) async {
    getCurrentUser();
    print(currentUser.displayName);
    await DatabaseService(uid: currentUser.uid)
        .createReport(currentUser.displayName, report);
  }

  Future updateHealthCondition(
      String address,
      String isVaccinated,
      String prefferedVaccine,
      String hasDryCough,
      String hasSoreThroat,
      String hasFever,
      String hasTiredness,
      String hasOthers) async {
    getCurrentUser();
    await DatabaseService(uid: currentUser.uid).updateUserHealthCondition(
        address,
        isVaccinated,
        prefferedVaccine,
        hasDryCough,
        hasSoreThroat,
        hasFever,
        hasTiredness,
        hasOthers);
  }
}
