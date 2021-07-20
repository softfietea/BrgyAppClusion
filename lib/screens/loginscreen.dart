import 'package:brgyapp/services/authservices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController lemail = TextEditingController();
  final TextEditingController lpassword = TextEditingController();

  final GlobalKey<FormState> _formLogin = GlobalKey<FormState>();

  _validateEmail() {
    if (lemail == null) {
      return ('Please input an Email');
    }
    if (lemail.value.toString().length > 50 &&
        lemail.value.toString().length < 5) {
      return ('Invalid Email');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3F5856),
      body: Container(
          margin: EdgeInsets.fromLTRB(0, 180, 0, 0),
          child: Form(
            key: _formLogin,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Clusion.',
                      style: GoogleFonts.spectral(
                          color: Color(0xffF5C69D),
                          fontSize: 40,
                          fontWeight: FontWeight.w700)),

                  //email
                  Container(
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ('Please input an Email');
                          } else if (value.length > 50 && value.length < 5) {
                            return ('Invalid Email');
                          }
                          return null;
                        },
                        controller: lemail,
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
                        validator: _validateEmail(),
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        controller: lpassword,
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

                  //ForgotPassword

                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Forgot Password? Click ',
                            style: GoogleFonts.spectral(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/forgotpass');
                            print('forgot password button');
                          },
                          child: Text('here',
                              style: GoogleFonts.spectral(
                                  color: Color(0xffF5C69D),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                  ),

                  // login button

                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xffF5C69D),
                            padding: EdgeInsets.fromLTRB(70, 10, 70, 10)),
                        onPressed: () async {
                          if (_formLogin.currentState.validate()) {
                            await context.read<AuthService>().signIn(
                                lemail.text.trim(), lpassword.text.trim());
                            Navigator.pushNamed(context, '/');
                          }
                        },
                        child: Text(
                          'Login',
                          style: GoogleFonts.spectral(
                              color: Color(0xff3F5856),
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        )),
                  ),

                  // register button

                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            side: BorderSide(
                                width: 1.0, color: Color(0xffF5C69D)),
                            primary: Color(0xff3F5856),
                            padding: EdgeInsets.fromLTRB(63, 10, 63, 10)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          'Register',
                          style: GoogleFonts.spectral(
                              color: Color(0xffF5C69D),
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        )),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
