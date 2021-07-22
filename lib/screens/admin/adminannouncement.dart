import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminAnnouncementScreen extends StatefulWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  _AdminAnnouncementScreenState createState() =>
      _AdminAnnouncementScreenState();
}

class _AdminAnnouncementScreenState extends State<AdminAnnouncementScreen> {
  final CollectionReference announceCollection =
      FirebaseFirestore.instance.collection('announcement');
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future deleteAnnouncement(index) async {
    await announceCollection.doc(index).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3F5856),
      body: Column(
        children: [
          SafeArea(
              child: Text("Hold Press to Delete",
                  style: GoogleFonts.spectral(
                      color: Color(0xffF5C69D),
                      fontSize: 30,
                      fontWeight: FontWeight.w700))),
          StreamBuilder<QuerySnapshot>(
              stream: widget._firestore.collection('announcement').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('Loading....');
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        String uid = snapshot.data.docs[index].id;
                        String itemTitle = snapshot.data.docs[index]['title'];
                        String itemDescription =
                            snapshot.data.docs[index]['description'];
                        return Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: GestureDetector(
                            onLongPress: () async {
                              await deleteAnnouncement(uid).whenComplete(() =>
                                  Fluttertoast.showToast(
                                      textColor: Color(0xff3F5856),
                                      msg: "Successfully Deleted",
                                      backgroundColor: Color(0xffF5C69D)));
                            },
                            child: CardItem(
                                itemTitle: itemTitle,
                                itemDescription: itemDescription),
                          ),
                        );
                      }),
                );
              }),
          Container(
            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
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
        title: Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
            child: Text(widget.itemTitle)),
        subtitle: Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
            child: Text(widget.itemDescription)),
      ),
    );
  }
}
