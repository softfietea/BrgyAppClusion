import 'package:brgyapp/services/authservices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _emailForgotPass = TextEditingController();
  final GlobalKey<FormState> _formForgotPass = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3F5856),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 100, 280, 0),
              child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: 30,
                  color: Color(0xffF5C69D),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Text('Forgot Password.',
                  style: GoogleFonts.spectral(
                      color: Color(0xffF5C69D),
                      fontSize: 40,
                      fontWeight: FontWeight.w700)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Text(
                  'Please Input your registered email and we will sent to you a link for new password',
                  style: GoogleFonts.spectral(
                      color: Color(0xffF5C69D),
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
            ),
            Form(
                key: _formForgotPass,
                child: Container(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: TextFormField(
                    controller: _emailForgotPass,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length > 30 ||
                          value.length < 6) {
                        _emailForgotPass.clear();
                        return ('Please input a valid Email');
                      } else {
                        return null;
                      }
                    },
                    style: TextStyle(color: Colors.white),
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: "Input Your Email",
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
                  ),
                )),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 1.0, color: Color(0xffF5C69D)),
                      primary: Color(0xffF5C69D),
                      padding: EdgeInsets.fromLTRB(63, 10, 63, 10)),
                  onPressed: () {
                    if (_formForgotPass.currentState.validate()) {
                      context
                          .read<AuthService>()
                          .forgetPassword(_emailForgotPass.text);
                      _emailForgotPass.clear();
                      FocusScope.of(context).unfocus();
                    }
                  },
                  child: Text(
                    'Request New Password',
                    style: GoogleFonts.spectral(
                        color: Color(0xff3F5856),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
