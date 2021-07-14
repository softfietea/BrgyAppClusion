import 'package:brgyapp/services/authservices.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3F5856),
      body: SingleChildScrollView(
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
                    await context.read<AuthService>().makeAnAnnouncement(
                        _titleAnnouncement.text.trim(),
                        _descriptionAnnouncement.text.trim());

                    _titleAnnouncement.clear();
                    _descriptionAnnouncement.clear();
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
                          side:
                              BorderSide(width: 1.0, color: Color(0xffF5C69D)),
                          primary: Color(0xff3F5856),
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10)),
                      onPressed: () async {
                        await context.read<AuthService>().signOut();
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
                          side:
                              BorderSide(width: 1.0, color: Color(0xffF5C69D)),
                          primary: Color(0xff3F5856),
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10)),
                      onPressed: () async {
                        Navigator.pushNamed(context, '/adminreport');
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
                          side:
                              BorderSide(width: 1.0, color: Color(0xffF5C69D)),
                          primary: Color(0xff3F5856),
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10)),
                      onPressed: () async {
                        Navigator.pushNamed(context, '/adminmanagement');
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
                      side: BorderSide(width: 1.0, color: Color(0xffF5C69D)),
                      primary: Color(0xff3F5856),
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10)),
                  onPressed: () async {
                    Navigator.pushNamed(context, '/admincomplains');
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
    );
  }
}
