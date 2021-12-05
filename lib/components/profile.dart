import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController name = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  bool isUpdated = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
    gender.dispose();
    mobile.dispose();
    pinCode.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          name.text = value.data()!["name"];
          gender.text = value.data()!["gender"];
          mobile.text = value.data()!["mobile"];
          pinCode.text = value.data()!["pinCode"];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 75, right: 25),
        child: Container(
          height: size.height,
          width: size.width * .6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Profile ",
                style: GoogleFonts.rajdhani(
                  textStyle: Theme.of(context).textTheme.headline4,
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size.height * .015,
              ),
              TextField(
                maxLines: 1,
                controller: name,
                onChanged: (value) => setState(() {
                  isUpdated = true;
                }),
                autofocus: false,
                textAlign: TextAlign.center,
                autocorrect: false,
                keyboardType: TextInputType.text,
                style: GoogleFonts.rajdhani(
                  textStyle: Theme.of(context).textTheme.headline4,
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: 'Name',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .015,
              ),
              TextField(
                maxLines: 1,
                controller: gender,
                onChanged: (value) => setState(() {
                  isUpdated = true;
                }),
                autofocus: false,
                textAlign: TextAlign.center,
                autocorrect: false,
                keyboardType: TextInputType.text,
                style: GoogleFonts.rajdhani(
                  textStyle: Theme.of(context).textTheme.headline4,
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: 'Gender',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .015,
              ),
              TextField(
                maxLines: 1,
                controller: mobile,
                onChanged: (value) => setState(() {
                  isUpdated = true;
                }),
                autofocus: false,
                textAlign: TextAlign.center,
                autocorrect: false,
                keyboardType: TextInputType.text,
                style: GoogleFonts.rajdhani(
                  textStyle: Theme.of(context).textTheme.headline4,
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: 'Mobile',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .015,
              ),
              TextField(
                maxLines: 1,
                controller: pinCode,
                onChanged: (value) => setState(() {
                  isUpdated = true;
                }),
                autofocus: false,
                textAlign: TextAlign.center,
                autocorrect: false,
                keyboardType: TextInputType.text,
                style: GoogleFonts.rajdhani(
                  textStyle: Theme.of(context).textTheme.headline4,
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: 'PinCode',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .025,
              ),
              if (isUpdated)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 15,
                    shadowColor: Colors.green,
                    primary: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 50),
                  ),
                  onPressed: () {
                    updateDetails();
                  },
                  child: Text(
                    "Update",
                    style: GoogleFonts.rajdhani(
                      textStyle: Theme.of(context).textTheme.headline4,
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              SizedBox(
                height: size.height * .015,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 15,
                  shadowColor: Colors.red,
                  primary: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/Login", (route) => false);
                },
                child: Text(
                  "Logout",
                  style: GoogleFonts.rajdhani(
                    textStyle: Theme.of(context).textTheme.headline4,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateDetails() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "name": name.text.trim(),
      "gender": gender.text.trim(),
      "mobile": mobile.text.trim(),
      "pinCode": pinCode.text.trim(),
    }, SetOptions(merge: true)).then((value) {
      Fluttertoast.showToast(msg: "details updated");
    });
    setState(() {
      isUpdated = false;
    });
  }
}
