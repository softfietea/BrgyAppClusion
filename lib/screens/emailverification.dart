import 'package:brgyapp/model/userapp.dart';
import 'package:brgyapp/services/authservices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff3F5856),
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(0, 200, 0, 0),
                child: Text('Email Verification',
                    style: GoogleFonts.spectral(
                        color: Color(0xffF5C69D),
                        fontSize: 40,
                        fontWeight: FontWeight.w700))),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                  'An Email has been Sent to you, If you will be Identified as not residents In Brgy. 347, your account would be deleted. Check your Email for verification before logging in.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.spectral(
                      color: Color(0xffF5C69D),
                      fontSize: 12,
                      fontWeight: FontWeight.w500)),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 1.0, color: Color(0xffF5C69D)),
                      primary: Color(0xffF5C69D),
                      padding: EdgeInsets.fromLTRB(63, 10, 63, 10)),
                  onPressed: () async {
                    context.read<AuthService>().signOut();

                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    'Go back to login',
                    style: GoogleFonts.spectral(
                        color: Color(0xff3F5856),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )),
            )
          ],
        ));
  }
}
