import 'package:brgyapp/model/userapp.dart';
import 'package:brgyapp/services/authservices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserHomeScreen extends StatefulWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Color(0xffF5C69D),
        child: Container(
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: GestureDetector(
                    onTap: () async {
                      await context
                          .read<AuthService>()
                          .signOut()
                          .then((value) => Navigator.pushNamed(context, '/'));
                    },
                    child: Icon(Icons.logout)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: Icon(Icons.home)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                    child: Icon(Icons.settings)),
              ),
            ],
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: Color(0xff3F5856),
      body: Center(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(0, 80, 195, 0),
                child: Text(
                  'Hello, User',
                  style: GoogleFonts.spectral(
                      color: Color(0xffF5C69D),
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                )),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                'Brgy Captain Alexis would like to know you more! Participate by answering and updating your health status. Help brgy to be Covid free.',
                textAlign: TextAlign.left,
                style: GoogleFonts.spectral(
                    color: Color(0xffF5C69D),
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 1.0, color: Color(0xffF5C69D)),
                      primary: Color(0xff3F5856),
                      padding: EdgeInsets.fromLTRB(63, 10, 63, 10)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/userform');
                  },
                  child: Text(
                    'Participate',
                    style: GoogleFonts.spectral(
                        color: Color(0xffF5C69D),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 50, 135, 10),
                child: Text(
                  'Announcement',
                  style: GoogleFonts.spectral(
                      color: Color(0xffF5C69D),
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                )),

//ListView Announcement

            StreamBuilder<QuerySnapshot>(
                stream:
                    widget._firestore.collection('announcement').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text('Loading....');
                  }
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          String itemTitle = snapshot.data.docs[index]['title'];
                          String itemDescription =
                              snapshot.data.docs[index]['description'];
                          return CardItem(
                              itemTitle: itemTitle,
                              itemDescription: itemDescription);
                        }),
                  );
                }),
          ],
        ),
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