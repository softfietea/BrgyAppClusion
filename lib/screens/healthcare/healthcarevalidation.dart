import 'package:brgyapp/services/authservices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future updateInfoValidate(index) async {
    return await useCollection.doc(index).update({
      'infovalidated': 'yes',
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
                                  ElevatedButton(
                                      onPressed: () async {
                                        updateInfoValidate(uid);
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
      child: ListTile(
        title: Text(widget.itemTitle),
        subtitle: Text(widget.itemDescription),
      ),
    );
  }
}
