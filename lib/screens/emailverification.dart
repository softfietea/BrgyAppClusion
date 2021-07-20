import 'dart:io';
import 'package:brgyapp/services/authservices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  UploadTask task;
  String uploadStatus = "";
  String urlTest = "";
  File _image;

  Future getImage() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image.path);
      print('image Path $_image');
      uploadStatus = 'Uploading';
    });
  }

  Future uploadPicture(String uid) async {
    String fileName = basename(_image.path);
    final destination = 'files/users/$uid/BrgyID/$fileName';

    Reference firebaseStorageRef = FirebaseStorage.instance.ref(destination);
    task = firebaseStorageRef.putFile(_image);

    final snapshot = await task.whenComplete(() => {
          setState(() {
            uploadStatus = 'Sucessfully Uploaded';
          })
        });
    final urlDownload = await snapshot.ref.getDownloadURL();

    setState(() {
      urlTest = urlDownload;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
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
                    'An Email has been Sent to you, please upload your brgy ID for validation that you are actually living in this brgy. If you will be Identified as not residents In Brgy. 347, your account will be deleted. Check your Email for verification before logging in and upload the brgy ID after you log in.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.spectral(
                        color: Color(0xffF5C69D),
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Column(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            side: BorderSide(
                                width: 1.0, color: Color(0xffF5C69D)),
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
                    /* ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            side:
                                BorderSide(width: 1.0, color: Color(0xffF5C69D)),
                            primary: Color(0xffF5C69D),
                            padding: EdgeInsets.fromLTRB(63, 10, 63, 10)),
                        onPressed: () async {
                          var currentUser =
                              context.read<AuthService>().getCurrentUser();
                          print(currentUser);
                          await getImage();
                          uploadPicture(currentUser);
                        },
                        child: Text(
                          'Upload Brgy ID ',
                          style: GoogleFonts.spectral(
                              color: Color(0xff3F5856),
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        )), */
                    Text('$uploadStatus'),
                    Image.network(urlTest),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
