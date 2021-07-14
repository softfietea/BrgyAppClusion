import 'package:brgyapp/model/userapp.dart';
import 'package:brgyapp/services/databaseservice.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<User> get authStateChanges => _auth.authStateChanges();

  User _loggedUser;

  final auth = FirebaseAuth.instance;
  User currentUser;

  /// Function to get the currently logged in user
  void getCurrentUser() {
    currentUser = auth.currentUser;
  }

  Future<bool> get userVerified async {
    await FirebaseAuth.instance.currentUser.reload();
    return FirebaseAuth.instance.currentUser.emailVerified;
  }

  //firebase custom user

  //sign in
  Future signIn(String signEmail, String signPassword) async {
    try {
      final signInUser = await _auth.signInWithEmailAndPassword(
          email: signEmail, password: signPassword);

      _loggedUser != null
          ? _loggedUser = signInUser.user
          : print('failed to sign in');
    } catch (e) {
      print(e.toString());
    }
  }

  //signout
  Future signOut() async {
    await _auth.signOut();
    await _loggedUser.reload();
  }

  //sign up
  Future signUp(String rEmail, String rPassword, String rFullname) async {
    try {
      UserCredential newUser = await _auth.createUserWithEmailAndPassword(
          email: rEmail, password: rPassword);

      newUser != null ? _loggedUser = newUser.user : print('failed to signUp');

      await _loggedUser.updateDisplayName(rFullname);

      await _loggedUser.sendEmailVerification();

      await DatabaseService(uid: _loggedUser.uid)
          .updateUserData(_loggedUser.email, rFullname);
    } catch (e) {
      print(e.toString());
    }
  }

  //forgetpassword
  Future forgetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  //delete account
  Future deleteAccount() async {}

  Future makeAnAnnouncement(String title, String description) async {
    await DatabaseService(uid: "adminAnnouncementUid")
        .createAnnouncement(title, description);
  }

  Future makeAReport(String report) async {
    getCurrentUser();
    print(currentUser.displayName);
    await DatabaseService(uid: currentUser.uid)
        .createReport(currentUser.displayName, report);
  }

  Future updateHealthCondition(
      String address,
      String isVaccinated,
      String prefferedVaccine,
      String hasDryCough,
      String hasSoreThroat,
      String hasFever,
      String hasTiredness,
      String hasOthers) async {
    getCurrentUser();
    await DatabaseService(uid: currentUser.uid).updateUserHealthCondition(
        address,
        isVaccinated,
        prefferedVaccine,
        hasDryCough,
        hasSoreThroat,
        hasFever,
        hasTiredness,
        hasOthers);
  }
}
