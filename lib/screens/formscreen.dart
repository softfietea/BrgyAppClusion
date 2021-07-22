import 'dart:io';

import 'package:brgyapp/services/authservices.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String vaccinatedStatusValue = 'no';
  String vaccinePreffered = '';
  bool dryIsChecked = false;
  bool soreIsChecked = false;
  bool feverIsChecked = false;
  bool tiredIsChecked = false;
  TextEditingController specifyOthers = TextEditingController();
  TextEditingController addressUser = TextEditingController();
  bool conditionIsChecked = false;
  final GlobalKey<FormState> _formHealth = GlobalKey<FormState>();
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
    String fileName = "HealthID";
    final destination = 'files/users/$uid/HealthID/$fileName';

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
        body: CupertinoScrollbar(
          child: SingleChildScrollView(
            child: Form(
              key: _formHealth,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 60, 285, 0),
                    child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        iconSize: 30,
                        color: Color(0xffF5C69D),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 120, 0),
                    child: Text(
                      'Set your status',
                      style: GoogleFonts.spectral(
                          color: Color(0xffF5C69D),
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                  ),

                  //Address

                  Container(
                    margin: EdgeInsets.fromLTRB(20, 30, 260, 0),
                    child: Text(
                      'Address',
                      style: GoogleFonts.spectral(
                          color: Color(0xffF5C69D),
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                    ),
                  ),

                  Container(
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length > 50 ||
                              value.length < 5) {
                            addressUser.clear();
                            return ('Please input a valid Address');
                          } else {
                            return null;
                          }
                        },
                        controller: addressUser,
                        style: TextStyle(color: Colors.white),
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: "Address",
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

                  Container(
                    margin: EdgeInsets.fromLTRB(20, 15, 180, 0),
                    child: Text(
                      'Already Vaccinated?',
                      style: GoogleFonts.spectral(
                          color: Color(0xffF5C69D),
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(40, 0, 20, 0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  activeColor: Color(0xffC9D0D0),
                                  value: 'no',
                                  groupValue: vaccinatedStatusValue,
                                  onChanged: (value) {
                                    setState(() {
                                      vaccinatedStatusValue = value;
                                    });
                                  },
                                ),
                                Text('No',
                                    style: GoogleFonts.spectral(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700))
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Radio(
                              activeColor: Color(0xffC9D0D0),
                              value: 'yes',
                              groupValue: vaccinatedStatusValue,
                              onChanged: (value) {
                                setState(() {
                                  vaccinatedStatusValue = value;
                                });
                              },
                            ),
                            Text('Yes',
                                style: GoogleFonts.spectral(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700))
                          ],
                        ),
                      ),
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Select your Preffered Vaccine";
                        }
                        return null;
                      },
                      hint: Text('Select Your Preffered Vaccine',
                          style: GoogleFonts.spectral(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w700)),
                      items: <String>[
                        'Pfizer',
                        'AstraZenica',
                        'Sinovac',
                        'Moderna',
                        'gamaleya',
                        'Novavax',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value,
                              style: GoogleFonts.spectral(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          vaccinePreffered = val;
                        });
                      },
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(20, 15, 180, 0),
                    child: Text(
                      'Check if you feel any of this.',
                      style: GoogleFonts.spectral(
                          color: Color(0xffF5C69D),
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Row(
                        children: [
                          Checkbox(
                              value: dryIsChecked,
                              onChanged: (bool val) {
                                setState(() {
                                  dryIsChecked = val;
                                });
                              }),
                          Text('Dry Cough',
                              style: GoogleFonts.spectral(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700))
                        ],
                      )),

                  Container(
                      margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Row(
                        children: [
                          Checkbox(
                              value: soreIsChecked,
                              onChanged: (bool val) {
                                setState(() {
                                  soreIsChecked = val;
                                });
                              }),
                          Text('Sore Throat',
                              style: GoogleFonts.spectral(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700))
                        ],
                      )),

                  Container(
                      margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Row(
                        children: [
                          Checkbox(
                              value: feverIsChecked,
                              onChanged: (bool val) {
                                setState(() {
                                  feverIsChecked = val;
                                });
                              }),
                          Text('Fever',
                              style: GoogleFonts.spectral(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700))
                        ],
                      )),

                  Container(
                      margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Row(
                        children: [
                          Checkbox(
                              value: tiredIsChecked,
                              onChanged: (bool val) {
                                setState(() {
                                  tiredIsChecked = val;
                                });
                              }),
                          Text('Tiredness',
                              style: GoogleFonts.spectral(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700))
                        ],
                      )),

                  Container(
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: TextFormField(
                        controller: specifyOthers,
                        style: TextStyle(color: Colors.white),
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: "Specify Others.",
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

                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            side: BorderSide(
                                width: 1.0, color: Color(0xffF5C69D)),
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
                          'Upload Vaccination ID or any Proof',
                          style: GoogleFonts.spectral(
                              color: Color(0xff3F5856),
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        )),
                  ),
                  Text('$uploadStatus',
                      style: GoogleFonts.spectral(
                        color: Color(0xffF5C69D),
                        fontSize: 20,
                      )),
                  Container(
                      color: Colors.black,
                      height: 200,
                      width: 350,
                      child: urlTest == ""
                          ? Center(
                              child: Text("Image Preview",
                                  style: GoogleFonts.spectral(
                                    color: Colors.white,
                                    fontSize: 15,
                                  )),
                            )
                          : Image.network(urlTest)),

                  Row(
                    children: [
                      Checkbox(
                          value: conditionIsChecked,
                          onChanged: (bool val) {
                            setState(() {
                              conditionIsChecked = val;
                            });
                          }),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 10, 0),
                          child: Text(
                              'I do hereby declare that all the information given above is true and accept to contribute personal data to help the app for covid 19 related solution',
                              style: GoogleFonts.spectral(
                                  color: Color(0xffF5C69D),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                        ),
                      )
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xffF5C69D),
                            padding: EdgeInsets.fromLTRB(70, 10, 70, 10)),
                        onPressed: () async {
                          if (_formHealth.currentState.validate() &&
                              conditionIsChecked == true) {
                            print(addressUser);
                            print(vaccinePreffered);
                            print("Vaccinated?" + vaccinatedStatusValue);
                            print("dry" + '$dryIsChecked');
                            print("sore" + '$soreIsChecked');
                            print("fever" + '$feverIsChecked');
                            print("tired" + '$tiredIsChecked');
                            print("specify value " + specifyOthers.text);
                            print("condition" + '$conditionIsChecked');

                            await context
                                .read<AuthService>()
                                .updateHealthCondition(
                                    addressUser.text,
                                    vaccinatedStatusValue,
                                    vaccinePreffered,
                                    dryIsChecked.toString(),
                                    soreIsChecked.toString(),
                                    feverIsChecked.toString(),
                                    tiredIsChecked.toString(),
                                    specifyOthers.text)
                                .whenComplete(() => Fluttertoast.showToast(
                                    textColor: Color(0xff3F5856),
                                    msg: "Your status was successfully updated",
                                    backgroundColor: Color(0xffF5C69D)))
                                .onError((error, stackTrace) =>
                                    Fluttertoast.showToast(
                                        textColor: Color(0xff3F5856),
                                        msg: error.toString()));

                            specifyOthers.clear();

                            Navigator.pushNamed(context, '/userhome');
                          } else if (conditionIsChecked == false) {
                            Fluttertoast.showToast(
                                textColor: Color(0xff3F5856),
                                msg: "Please check the condition.",
                                backgroundColor: Color(0xffF5C69D));
                          }
                        },
                        child: Text(
                          'Submit',
                          style: GoogleFonts.spectral(
                              color: Color(0xff3F5856),
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
    );
  }
}
