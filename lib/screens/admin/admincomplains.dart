import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminComplainScreen extends StatefulWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  _AdminComplainScreenState createState() => _AdminComplainScreenState();
}

class _AdminComplainScreenState extends State<AdminComplainScreen> {
  final CollectionReference reportCollection =
      FirebaseFirestore.instance.collection('report');

  Future deleteAnnouncement(index) async {
    await reportCollection.doc(index).delete();
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
            height: 600,
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              children: [
                Text(
                  'Complaints',
                  style: GoogleFonts.spectral(
                      color: Color(0xffF5C69D),
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  'long press to delete',
                  style: GoogleFonts.spectral(
                      color: Color(0xffF5C69D),
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: widget._firestore.collection('report').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading....');
                      }
                      return Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              String uid = snapshot.data.docs[index].id;
                              String itemTitle =
                                  snapshot.data.docs[index]['user'];
                              String itemDescription =
                                  snapshot.data.docs[index]['report'];
                              return GestureDetector(
                                onLongPress: () async {
                                  await deleteAnnouncement(uid)
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              textColor: Color(0xff3F5856),
                                              msg: "Successfully Deleted",
                                              backgroundColor:
                                                  Color(0xffF5C69D)))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              textColor: Color(0xff3F5856),
                                              msg: "Something went wrong",
                                              backgroundColor:
                                                  Color(0xffF5C69D)));
                                },
                                child: CardItem(
                                    itemTitle: itemTitle,
                                    itemDescription: itemDescription),
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
                  'Back',
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
