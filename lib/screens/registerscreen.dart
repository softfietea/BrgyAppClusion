import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';

import 'package:brgyapp/model/userapp.dart';
import 'package:brgyapp/services/authservices.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController rFullnameR = TextEditingController();
  final TextEditingController rEmailR = TextEditingController();
  final TextEditingController rPasswordR = TextEditingController();
  final TextEditingController rCPasswordR = TextEditingController();
  final GlobalKey<FormState> _formRegister = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        backgroundColor: Color(0xff3F5856),
        body: Builder(
          builder: (context) => Container(
            child: SingleChildScrollView(
              child: Form(
                key: _formRegister,
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 130, 0, 0),
                        child: Text('Register.',
                            style: GoogleFonts.spectral(
                                color: Color(0xffF5C69D),
                                fontSize: 40,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    Container(
                      child: Text('Exclusive for brgy 347 residence.',
                          style: GoogleFonts.spectral(
                              color: Color(0xffF5C69D),
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                    ),

                    //fullname
                    Container(
                        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length > 30 ||
                                value.length < 5) {
                              rFullnameR.clear();
                              return ('Please input a valid Name');
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(color: Colors.white),
                          controller: rFullnameR,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: "Fullname",
                            fillColor: Colors.white,
                            labelStyle: GoogleFonts.spectral(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        )),

//email
                    Container(
                        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length > 30 ||
                                value.length < 5) {
                              rEmailR.clear();
                              return ('Please input a valid Email');
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(color: Colors.white),
                          controller: rEmailR,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: "Email",
                            fillColor: Colors.white,
                            labelStyle: GoogleFonts.spectral(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        )),

                    //password

                    Container(
                        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length > 30 ||
                                value.length < 6) {
                              rPasswordR.clear();
                              return ('Please input a valid Password, it must be atleast 6 letters');
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                          controller: rPasswordR,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: "Password",
                            fillColor: Colors.white,
                            labelStyle: GoogleFonts.spectral(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        )),

//confirm password

                    Container(
                        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length > 30 ||
                                value.length < 6 ||
                                value != rPasswordR.text) {
                              rCPasswordR.clear();
                              return ('make sure the password is the same in the first one');
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                          controller: rCPasswordR,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            fillColor: Colors.white,
                            labelStyle: GoogleFonts.spectral(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        )),

                    //Register Button

                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xffF5C69D),
                              padding: EdgeInsets.fromLTRB(70, 10, 70, 10)),
                          onPressed: () async {
                            if (_formRegister.currentState.validate()) {
                              await context.read<AuthService>().signUp(
                                  rEmailR.text.trim(),
                                  rPasswordR.text.trim(),
                                  rFullnameR.text.trim());

                              Navigator.pushNamed(context, '/');
                            }
                          },
                          child: Text(
                            'Register',
                            style: GoogleFonts.spectral(
                                color: Color(0xff3F5856),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          )),
                    ),

// back button
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                  width: 1.0, color: Color(0xffF5C69D)),
                              primary: Color(0xff3F5856),
                              padding: EdgeInsets.fromLTRB(80, 10, 80, 10)),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Back',
                            style: GoogleFonts.spectral(
                                color: Color(0xffF5C69D),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
