import 'package:brgyapp/services/authservices.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final TextEditingController _titleAnnouncement = TextEditingController();
  final TextEditingController _descriptionAnnouncement =
      TextEditingController();
  final GlobalKey<FormState> _formAnnouncement = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        backgroundColor: Color(0xff3F5856),
        body: SingleChildScrollView(
          child: Form(
            key: _formAnnouncement,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
                  child: Text('Announce',
                      style: GoogleFonts.spectral(
                          color: Color(0xffF5C69D),
                          fontSize: 40,
                          fontWeight: FontWeight.w700)),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length > 20 ||
                            value.length < 5) {
                          _titleAnnouncement.clear();
                          return ('Please input a valid title');
                        } else {
                          return null;
                        }
                      },
                      controller: _titleAnnouncement,
                      style: TextStyle(color: Colors.white),
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: "Title",
                        fillColor: Colors.white,
                        labelStyle: GoogleFonts.spectral(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    )),
                Container(
                  height: 150,
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Ink(
                      color: Colors.white,
                      child: TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length > 100 ||
                                value.length < 5) {
                              _descriptionAnnouncement.clear();
                              return ('Please input a valid Description');
                            } else {
                              return null;
                            }
                          },
                          controller: _descriptionAnnouncement,
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
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 50),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffF5C69D),
                          padding: EdgeInsets.fromLTRB(70, 10, 70, 10)),
                      onPressed: () async {
                        if (_formAnnouncement.currentState.validate()) {
                          await context
                              .read<AuthService>()
                              .makeAnAnnouncement(
                                  _titleAnnouncement.text.trim(),
                                  _descriptionAnnouncement.text.trim())
                              .whenComplete(() => Fluttertoast.showToast(
                                  textColor: Color(0xff3F5856),
                                  msg:
                                      "Announcement was sucessfully broadcasted",
                                  backgroundColor: Color(0xffF5C69D)));

                          _titleAnnouncement.clear();
                          _descriptionAnnouncement.clear();
                        }
                      },
                      child: Text(
                        'Announce',
                        style: GoogleFonts.spectral(
                            color: Color(0xff3F5856),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                  width: 1.0, color: Color(0xffF5C69D)),
                              primary: Color(0xff3F5856),
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 10)),
                          onPressed: () async {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return WillPopScope(
                                    onWillPop: () {},
                                    child: AlertDialog(
                                      backgroundColor: Color(0xffF5C69D),
                                      content: Container(
                                        height: 120,
                                        child: Column(
                                          children: [
                                            Text(
                                                "Are you sure you want to log out? ",
                                                style: GoogleFonts.spectral(
                                                    color: Color(0xff3F5856),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Color(0xff3F5856)),
                                                onPressed: () async {
                                                  await context
                                                      .read<AuthService>()
                                                      .signOut()
                                                      .whenComplete(() =>
                                                          Navigator.pushNamed(
                                                              context, '/'));
                                                },
                                                child: Text('Confirm Logout')),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Color(0xff3F5856)),
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Back'))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Text(
                            'Logout',
                            style: GoogleFonts.spectral(
                                color: Color(0xffF5C69D),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                  width: 1.0, color: Color(0xffF5C69D)),
                              primary: Color(0xff3F5856),
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 10)),
                          onPressed: () async {
                            Navigator.pushNamed(context, '/adminreport');
                            FocusScope.of(context).unfocus();
                          },
                          child: Text(
                            'Analytics',
                            style: GoogleFonts.spectral(
                                color: Color(0xffF5C69D),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                  width: 1.0, color: Color(0xffF5C69D)),
                              primary: Color(0xff3F5856),
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 10)),
                          onPressed: () async {
                            Navigator.pushNamed(context, '/adminmanagement');
                            FocusScope.of(context).unfocus();
                          },
                          child: Text(
                            'Manage',
                            style: GoogleFonts.spectral(
                                color: Color(0xffF5C69D),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          )),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side:
                              BorderSide(width: 1.0, color: Color(0xffF5C69D)),
                          primary: Color(0xff3F5856),
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10)),
                      onPressed: () async {
                        Navigator.pushNamed(context, '/admincomplains');
                        FocusScope.of(context).unfocus();
                      },
                      child: Text(
                        'Reports',
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
    );
  }
}
