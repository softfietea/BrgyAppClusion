import 'package:brgyapp/services/authservices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController _reportMessage = TextEditingController();
  final GlobalKey<FormState> _formReport = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3F5856),
      body: SingleChildScrollView(
        child: Form(
          key: _formReport,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 150, 0, 0),
                child: Text('Report',
                    style: GoogleFonts.spectral(
                        color: Color(0xffF5C69D),
                        fontSize: 40,
                        fontWeight: FontWeight.w700)),
              ),
              Container(
                height: 150,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Ink(
                    color: Colors.white,
                    child: TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length > 200 ||
                              value.length < 5) {
                            _reportMessage.clear();
                            return "Please Input valid description";
                          }
                          return null;
                        },
                        controller: _reportMessage,
                        maxLines: null,
                        decoration: new InputDecoration(
                          hintText: "Description",
                          hintStyle: GoogleFonts.spectral(
                              color: Colors.black38,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                        ))),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xffF5C69D),
                        padding: EdgeInsets.fromLTRB(70, 10, 70, 10)),
                    onPressed: () async {
                      if (_formReport.currentState.validate()) {
                        await context
                            .read<AuthService>()
                            .makeAReport(_reportMessage.text);

                        _reportMessage.clear();
                        Fluttertoast.showToast(
                            textColor: Color(0xff3F5856),
                            msg: "The report was successfully submitted",
                            backgroundColor: Color(0xffF5C69D));
                      } else {
                        Fluttertoast.showToast(
                            textColor: Color(0xff3F5856),
                            msg: "Something went wrong",
                            backgroundColor: Color(0xffF5C69D));
                      }
                    },
                    child: Text(
                      'Report',
                      style: GoogleFonts.spectral(
                          color: Color(0xff3F5856),
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    )),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 1.0, color: Color(0xffF5C69D)),
                        primary: Color(0xff3F5856),
                        padding: EdgeInsets.fromLTRB(63, 10, 63, 10)),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
