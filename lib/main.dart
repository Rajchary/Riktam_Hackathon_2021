import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karma/Signup/signup.dart';
import 'package:karma/components/available_requests.dart';
import 'package:karma/components/borrow_request.dart';
import 'package:karma/components/help_approval.dart';
import 'package:karma/components/profile.dart';
import 'package:karma/components/splash.dart';
import 'package:karma/components/transaction_aproval.dart';
import 'package:karma/login/login.dart';

import 'components/home.dart';
import 'components/parent.dart';
import 'components/request.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Karma',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/Splash',
      routes: {
        '/Splash': (context) => const Splash(),
        '/Home': (context) => const Home(),
        '/Signup': (context) => const Signup(),
        '/Login': (context) => const Login(),
        '/Parent': (context) => const Parent(),
        '/Profile': (context) => const Profile(),
        '/BorrowRequest': (context) => const BorrowRequest(),
        '/FetchRequest': (context) => const FetchRequest(),
        '/Request': (context) => const Request(),
        '/Aproval': (context) => const Approval(),
        '/HelpApproval': (context) => const HelpApproval(),
      },
    );
  }
}
