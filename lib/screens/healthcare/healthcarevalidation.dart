import 'package:brgyapp/services/authservices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HealthCareScreen extends StatefulWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  _HealthCareScreenState createState() => _HealthCareScreenState();
}

class _HealthCareScreenState extends State<HealthCareScreen> {
  final CollectionReference useCollection =
      FirebaseFirestore.instance.collection('users');
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String task;
  String errorText;

  String urlTest;
  String destination;

  Future updateInfoValidate(index) async {
    return await useCollection.doc(index).update({
      'infovalidated': 'yes',
    });
  }

  Future showHealthID(uid) async {
    String fileName = "HealthID";
    String destination = 'files/users/$uid/HealthID/$fileName';
    Reference firebaseStorageRef = FirebaseStorage.instance.ref(destination);
    try {
      task = await firebaseStorageRef.getDownloadURL();
    } catch (e) {
      setState(() {
        errorText = e.toString();
      });
    }
    setState(() {
      urlTest = task;
    });
  }

  refreshDialog() {
    setState(() {
      task = null;
      errorText = null;
      urlTest = null;
      destination = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3F5856),
      body:

//ListView Announcement

          Column(
        children: [
          Container(
            height: 650,
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: widget._firestore
                        .collection('users')
                        .where('infovalidated', isEqualTo: "no")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }
                      return Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              String uid = snapshot.data.docs[index].id;
                              String itemTitle =
                                  snapshot.data.docs[index]["fullname"];
                              String itemDescription =
                                  snapshot.data.docs[index]["infovalidated"];
                              return Row(
                                children: [
                                  Expanded(
                                    child: CardItem(
                                        itemTitle: itemTitle,
                                        itemDescription: itemDescription),
                                  ),
                                  Container(
                                    height: 70,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Color(0xffF5C69D)),
                                        onPressed: () async {
                                          updateInfoValidate(uid);
                                        },
                                        child: Icon(Icons.healing_outlined)),
                                  ),
                                  Container(
                                    height: 70,
                                    margin: EdgeInsets.fromLTRB(3.5, 0, 0, 0),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Color(0xffF5C69D)),
                                        onPressed: () async {
                                          await refreshDialog();
                                          await showHealthID(uid);
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return WillPopScope(
                                                  onWillPop: () {},
                                                  child: AlertDialog(
                                                    content: Container(
                                                      height: 400,
                                                      child: Column(
                                                        children: [
                                                          urlTest != null
                                                              ? Container(
                                                                  width: 350,
                                                                  height: 350,
                                                                  child: Image
                                                                      .network(
                                                                    urlTest,
                                                                    loadingBuilder:
                                                                        (context,
                                                                            child,
                                                                            loadingProgress) {
                                                                      if (loadingProgress ==
                                                                          null)
                                                                        return child;
                                                                      return Center(
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          value: loadingProgress.expectedTotalBytes != null
                                                                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                                                              : null,
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                )
                                                              : Container(
                                                                  height: 50,
                                                                  width: 50,
                                                                  child: Text(
                                                                      errorText),
                                                                ),
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  urlTest =
                                                                      null;

                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                });
                                                              },
                                                              child:
                                                                  Text('Back'))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        child: Icon(Icons.image)),
                                  )
                                ],
                              );
                            }),
                      );
                    }),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    side: BorderSide(width: 1.0, color: Color(0xffF5C69D)),
                    primary: Color(0xff3F5856),
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10)),
                onPressed: () async {
                  context.read<AuthService>().signOut();
                },
                child: Text(
                  'Logout',
                  style: GoogleFonts.spectral(
                      color: Color(0xffF5C69D),
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                )),
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatefulWidget {
  String itemTitle;
  String itemDescription;

  CardItem({this.itemTitle, this.itemDescription});

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffF5C69D),
      child: ListTile(
        title: Text(
          widget.itemTitle,
          style: GoogleFonts.spectral(
              color: Color(0xff3F5856),
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          "Info Validated: " + widget.itemDescription,
          style: GoogleFonts.spectral(
              color: Color(0xff3F5856),
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
