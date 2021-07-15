import 'package:brgyapp/services/authservices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminManagementScreen extends StatefulWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  _AdminManagementScreenState createState() => _AdminManagementScreenState();
}

class _AdminManagementScreenState extends State<AdminManagementScreen> {
  final CollectionReference useCollection =
      FirebaseFirestore.instance.collection('users');
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future updateInfoValidate(index) async {
    return await useCollection.doc(index).update({
      'infovalidated': 'yes',
    });
  }

  Future updateBrgyIDValidate(index) async {
    return await useCollection.doc(index).update({
      'brgyIDValidated': 'yes',
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
            height: 200,
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: widget._firestore
                        .collection('users')
                        .where('role', isEqualTo: "resident")
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
                                  snapshot.data.docs[index]["email"];
                              return Row(
                                children: [
                                  Expanded(
                                    child: CardItem(
                                        itemTitle: itemTitle,
                                        itemDescription: itemDescription),
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        updateInfoValidate(uid);
                                      },
                                      child: Text('Ban')),
                                  ElevatedButton(
                                      onPressed: () async {
                                        updateBrgyIDValidate(uid);
                                      },
                                      child: Text('Validate'))
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
                  Navigator.pop(context);
                },
                child: Text(
                  'back',
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
      child: ListTile(
        title: Text(widget.itemTitle),
        subtitle: Text(widget.itemDescription),
      ),
    );
  }
}
