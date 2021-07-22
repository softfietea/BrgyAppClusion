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
  String userName = " ";
  String firstNameeto;
  String lastNameeto;

  @override
  void initState() {
    super.initState();

    userName = context.read<AuthService>().getCurrentName();

    var names = userName.split(' ');
    print(names);
    String firstName = names[0];
    String lastName = names[1];
    firstNameeto = firstName;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        backgroundColor: Color(0xff3F5856),
        body: Center(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 80, 195, 0),
                  child: Text(
                    'Hello, $firstNameeto',
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
                      'Set Health Status',
                      style: GoogleFonts.spectral(
                          color: Color(0xffF5C69D),
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: GestureDetector(
                          onTap: () async {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return WillPopScope(
                                    onWillPop: () {},
                                    child: AlertDialog(
                                      backgroundColor: Color(0xffF5C69D),
                                      content: Container(
                                        height: 120,
                                        child: Column(
                                          children: [
                                            Text(
                                                "Are you sure you want to log out? ",
                                                style: GoogleFonts.spectral(
                                                    color: Color(0xff3F5856),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Color(0xff3F5856)),
                                                onPressed: () async {
                                                  await context
                                                      .read<AuthService>()
                                                      .signOut()
                                                      .whenComplete(() =>
                                                          Navigator.pushNamed(
                                                              context, '/'));
                                                },
                                                child: Text('Confirm Logout')),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Color(0xff3F5856)),
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Back'))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Icon(
                            Icons.logout,
                            color: Color(0xffF5C69D),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Icon(
                            Icons.message_rounded,
                            color: Color(0xffF5C69D),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/settings');
                          },
                          child: Icon(
                            Icons.report,
                            color: Color(0xffF5C69D),
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 135, 10),
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
                            String itemTitle =
                                snapshot.data.docs[index]['title'];
                            String itemDescription =
                                snapshot.data.docs[index]['description'];
                            return Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                              color: Colors.black,
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
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Text(widget.itemTitle,
              style: GoogleFonts.spectral(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
        ),
        subtitle: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text(widget.itemDescription,
                style: GoogleFonts.spectral(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.w500))),
      ),
    );
  }
}
