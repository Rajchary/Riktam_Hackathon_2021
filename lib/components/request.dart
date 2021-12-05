import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  Map<String, dynamic> data = {};
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        color: Color(0xFF1B222E),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Name",
                  style: GoogleFonts.rajdhani(
                    textStyle: Theme.of(context).textTheme.headline4,
                    color: Colors.blue,
                    fontSize: size.width * .045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  " ${data["Name"]}",
                  style: GoogleFonts.rajdhani(
                    textStyle: Theme.of(context).textTheme.headline4,
                    color: Colors.red,
                    fontSize: size.width * .045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * .015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Karma Points",
                  style: GoogleFonts.rajdhani(
                    textStyle: Theme.of(context).textTheme.headline4,
                    color: Colors.blue,
                    fontSize: size.width * .045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "₹ ${data["karmPoints"]}",
                  style: GoogleFonts.rajdhani(
                    textStyle: Theme.of(context).textTheme.headline4,
                    color: Colors.red,
                    fontSize: size.width * .045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * .015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cause",
                  style: GoogleFonts.rajdhani(
                    textStyle: Theme.of(context).textTheme.headline4,
                    color: Colors.blue,
                    fontSize: size.width * .045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  " ${data["description"]}",
                  maxLines: 4,
                  style: GoogleFonts.rajdhani(
                    textStyle: Theme.of(context).textTheme.headline4,
                    color: Colors.red,
                    fontSize: size.width * .045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * .035,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 15,
                shadowColor: Colors.green,
                primary: Colors.green,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              ),
              onPressed: () {
                offerHelp();
              },
              child: Text(
                "Offer help",
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
    );
  }

  Future<void> offerHelp() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(data["uid"])
        .collection("helpReceived")
        .doc(data["Name"])
        .set({
      "Name": data["Name"],
      "KarmaPoints": data["karmPoints"],
      "offeredBy": FirebaseAuth.instance.currentUser!.uid.toString(),
      "cause": data["description"]
    }).whenComplete(() {
      Fluttertoast.showToast(msg: "User Notified...");
      Navigator.pop(context);
    }).catchError((error) {
      print(error);
    });
  }
}
