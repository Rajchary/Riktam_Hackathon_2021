import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpApproval extends StatefulWidget {
  const HelpApproval({Key? key}) : super(key: key);

  @override
  _HelpApprovalState createState() => _HelpApprovalState();
}

class _HelpApprovalState extends State<HelpApproval> {
  Map<String, dynamic> itemData = {};
  Map<String, dynamic> userData = {};
  int kPoints = 0, kPointsOfHelper = 0;
  bool disabled = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        kPoints = value.data()!["KarmaPoints"];
        if (kPoints - itemData["KarmaPoints"] <= 0) {
          disabled = true;
        }
      });
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(itemData["offeredBy"])
        .get()
        .then((value) {
      setState(() {
        kPointsOfHelper = value.data()!["KarmaPoints"];
        kPointsOfHelper += itemData["KarmaPoints"] as int;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    itemData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
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
                  " ${itemData["Name"]}",
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
                  "₹ ${itemData["KarmaPoints"]}",
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
                  " ${itemData["cause"]}",
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
            if (!disabled)
              Text(
                "Note : By acceptiong the help your karma points will be deducted which is irreversible",
                maxLines: 4,
                style: GoogleFonts.rajdhani(
                  textStyle: Theme.of(context).textTheme.headline4,
                  color: Colors.red,
                  fontSize: size.width * .035,
                  fontWeight: FontWeight.bold,
                ),
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
                shadowColor: disabled ? Colors.red : Colors.green,
                primary: disabled ? Colors.red : Colors.green,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              ),
              onPressed: disabled
                  ? null
                  : () async {
                      await completeTransactions().whenComplete(() {
                        Fluttertoast.showToast(msg: "Successfully Completed!!");
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/Parent', (route) => false);
                      });
                    },
              child: Text(
                disabled ? "Not Enough Points!!" : "Accept help",
                style: GoogleFonts.rajdhani(
                  textStyle: Theme.of(context).textTheme.headline4,
                  color: disabled ? Colors.red : Colors.white,
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

  Future<void> completeTransactions() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(itemData["offeredBy"])
        .set({"KarmaPoints": kPointsOfHelper},
            SetOptions(merge: true)).whenComplete(() async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({"KarmaPoints": kPoints - (itemData["KarmaPoints"] as int)},
              SetOptions(merge: true));
    }).whenComplete(() async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("helpReceived")
          .doc(itemData["Name"])
          .delete()
          .whenComplete(() async {
        await FirebaseFirestore.instance
            .collection("requests")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .delete();
      });
    });
    await FirebaseFirestore.instance
        .collection("Transactions")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("helpedfrom")
        .doc(userData["offeredBy"])
        .set({
      "Name": itemData["Name"],
      "cause": itemData["cause"],
      "KarmaPoints": itemData["KarmaPoints"],
      "offeredBy": itemData["offeredBy"],
    }).whenComplete(() async {
      await FirebaseFirestore.instance
          .collection("Transactions")
          .doc(itemData["offeredBy"])
          .collection("helpedto")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "Name": itemData["Name"],
        "cause": itemData["cause"],
        "KarmaPoints": itemData["KarmaPoints"],
        "offeredTo": FirebaseAuth.instance.currentUser!.uid,
      });
    });
  }
}
