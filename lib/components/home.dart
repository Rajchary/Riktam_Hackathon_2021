import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karma/Signup/signup.dart';
import 'package:karma/components/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> mp = {
    "empty": true,
    "name": "",
    "KarmaPoints": 0,
    "email": "",
    "mobile": "",
    "pinCpde": "",
    "gender": "NA"
  };
  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  _getUserData() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        value.data()!.forEach((key, value) async {
          setState(() {
            mp[key.toString()] = value;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
        child: Container(
          height: size.height * .7,
          width: size.width * .9,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    mp["gender"] == "Male"
                        ? "assets/images/male_avatar.jpg"
                        : "assets/images/female_avatar.jpg",
                    width: size.width * .12,
                    height: size.height * .1,
                  ),
                  SizedBox(width: size.width * .05),
                  Text(
                    "hi ",
                    style: GoogleFonts.rajdhani(
                      textStyle: Theme.of(context).textTheme.headline4,
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    " ${mp["name"]} ",
                    style: GoogleFonts.rajdhani(
                      textStyle: Theme.of(context).textTheme.headline4,
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Box(size: size, inputSize: .15),
              Container(
                height: size.height * .3,
                width: size.width * .6,
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Your Dashboard",
                      style: GoogleFonts.rajdhani(
                        textStyle: Theme.of(context).textTheme.headline4,
                        color: Colors.grey,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Box(size: size, inputSize: .025),
                    Text(
                      "₹ ${mp["KarmaPoints"]}",
                      style: GoogleFonts.rajdhani(
                        textStyle: Theme.of(context).textTheme.headline4,
                        color: Colors.indigo,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Box(size: size, inputSize: .025),
                    Text(
                      "Help others around you and get more karma points",
                      maxLines: 3,
                      style: GoogleFonts.rajdhani(
                        textStyle: Theme.of(context).textTheme.headline4,
                        color: Colors.grey[600],
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
