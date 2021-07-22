import 'package:brgyapp/model/userapp.dart';
import 'package:brgyapp/screens/admin/adminannouncement.dart';
import 'package:brgyapp/screens/admin/admincomplains.dart';
import 'package:brgyapp/screens/admin/adminhome.dart';
import 'package:brgyapp/screens/admin/adminmanagement.dart';
import 'package:brgyapp/screens/admin/adminreport.dart';
import 'package:brgyapp/screens/emailverification.dart';
import 'package:brgyapp/screens/forgotpassscreen.dart';
import 'package:brgyapp/screens/formscreen.dart';
import 'package:brgyapp/screens/loginscreen.dart';
import 'package:brgyapp/screens/registerscreen.dart';
import 'package:brgyapp/screens/settingscreen.dart';
import 'package:brgyapp/screens/userhome.dart';
import 'package:brgyapp/screens/wrapperauth.dart';
import 'package:brgyapp/screens/wrapperrole.dart';
import 'package:brgyapp/services/authservices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        Provider<AppUser>(
          create: (_) => AppUser(),
        ),
        StreamProvider(
            create: (context) => context.read<AuthService>().authStateChanges,
            initialData: null)
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => WrapperAuth(),
          '/role': (context) => WrapperRole(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/forgotpass': (context) => ForgotPasswordScreen(),
          '/userhome': (context) => UserHomeScreen(),
          '/emailverification': (context) => EmailVerificationScreen(),
          '/userform': (context) => FormScreen(),
          '/settings': (context) => SettingsScreen(),
          '/adminhome': (context) => AdminHomeScreen(),
          '/adminmanagement': (context) => AdminManagementScreen(),
          '/adminreport': (context) => AdminReportScreen(),
          '/admincomplains': (context) => AdminComplainScreen(),
          '/adminannouncement': (context) => AdminAnnouncementScreen(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
