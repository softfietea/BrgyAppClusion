import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference useCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference announcementCollection =
      FirebaseFirestore.instance.collection('announcement');

  final CollectionReference reportCollection =
      FirebaseFirestore.instance.collection('report');

  Future updateUserData(String email, String fullname) async {
    if (email == "mactribaco@tip.edu.ph") {
      return await useCollection.doc(uid).set({
        'fullname': fullname,
        'email': email,
        'address': "",
        'brgyIDValidated': "yes",
        'role': "admin",
      });
    } else if (email == "tribaco.alfie@gmail.com") {
      return await useCollection.doc(uid).set({
        'fullname': fullname,
        'email': email,
        'address': "",
        'brgyIDValidated': "yes",
        'role': "healthcare",
      });
    } else {
      return await useCollection.doc(uid).set({
        'fullname': fullname,
        'email': email,
        'address': "",
        'brgyIDValidated': "no",
        'role': "resident",
      });
    }
  }

  Future createAnnouncement(String title, String description) async {
    return await announcementCollection.add({
      'title': title,
      'description': description,
    });
  }

  Future createReport(String user, String report) async {
    return await reportCollection.add({
      'user': user,
      'report': report,
    });
  }

  Future updateUserHealthCondition(
      String address,
      String isVaccinated,
      String prefferedVaccine,
      String hasDryCough,
      String hasSoreThroat,
      String hasFever,
      String hasTiredness,
      String hasOthers) async {
    return await useCollection.doc(uid).update({
      'address': address,
      'isVaccinated': isVaccinated,
      'prefferedVaccine': prefferedVaccine,
      'hasDryCough': hasDryCough,
      'hasSoreThroat': hasSoreThroat,
      'hasFever': hasFever,
      'hasTiredness': hasTiredness,
      'hasOthers': hasOthers,
      'infovalidated': 'no'
    });
  }
}
