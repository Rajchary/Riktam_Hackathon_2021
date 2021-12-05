import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karma/Signup/signup.dart';

class BorrowRequest extends StatefulWidget {
  const BorrowRequest({Key? key}) : super(key: key);

  @override
  _BorrowRequestState createState() => _BorrowRequestState();
}

class _BorrowRequestState extends State<BorrowRequest> {
  TextEditingController itemName = TextEditingController();
  TextEditingController karmaPoints = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    const TextStyle labelStyle = TextStyle(color: Colors.blueGrey);
    const InputBorder focusBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8), topRight: Radius.circular(8)),
    );
    const TextStyle inputTextStyle = TextStyle(
        fontSize: 22, color: Colors.blueGrey, fontStyle: FontStyle.italic);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 40, right: 30, top: 100),
        child: Container(
          height: size.height * .8,
          width: size.width * .8,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Box(size: size, inputSize: .055),
              TextField(
                controller: itemName,
                autofocus: true,
                textAlign: TextAlign.center,
                autocorrect: false,
                keyboardType: TextInputType.name,
                onChanged: (String value) {
                  if (value.isEmpty) {
                    Fluttertoast.showToast(msg: "Item name was left empty");
                  }
                },
                decoration: const InputDecoration(
                    labelText: "Item name *",
                    labelStyle: labelStyle,
                    focusedBorder: focusBorder),
                style: inputTextStyle,
              ),
              Box(size: size, inputSize: .045),
              TextField(
                controller: karmaPoints,
                autofocus: true,
                textAlign: TextAlign.center,
                autocorrect: false,
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  if (value.isEmpty) {
                    Fluttertoast.showToast(msg: "Karma points was left empty");
                  }
                },
                decoration: const InputDecoration(
                    labelText: "karma Points *",
                    labelStyle: labelStyle,
                    focusedBorder: focusBorder),
                style: inputTextStyle,
              ),
              Box(size: size, inputSize: .045),
              TextField(
                controller: pinCode,
                autofocus: true,
                textAlign: TextAlign.center,
                autocorrect: false,
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  if (value.isEmpty) {
                    Fluttertoast.showToast(msg: "Pin code was left empty");
                  }
                },
                decoration: const InputDecoration(
                    labelText: "Pin Code *",
                    labelStyle: labelStyle,
                    focusedBorder: focusBorder),
                style: inputTextStyle,
              ),
              Box(size: size, inputSize: .04),
              TextField(
                maxLines: 3,
                controller: description,
                autofocus: true,
                textAlign: TextAlign.center,
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Description(optional)",
                    labelStyle: labelStyle,
                    focusedBorder: focusBorder),
                style: inputTextStyle,
              ),
              Box(size: size, inputSize: .04),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 15,
                  shadowColor: Colors.grey[600],
                  primary: Colors.blueGrey,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                ),
                onPressed: () {
                  if (itemName.text.isEmpty ||
                      karmaPoints.text.isEmpty ||
                      pinCode.text.isEmpty ||
                      pinCode.text.length != 6 ||
                      int.parse(karmaPoints.text) < 10) {
                    Fluttertoast.showToast(msg: "1 or more rules voilated!");
                  } else {
                    postRequest();
                  }
                },
                child: Text(
                  "Borrow help",
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

  Future<void> postRequest() async {
    await FirebaseFirestore.instance
        .collection("requests")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "Name": itemName.text,
      "pinCode": pinCode.text,
      "karmPoints": int.parse(karmaPoints.text),
      "description": description.text,
      "uid": FirebaseAuth.instance.currentUser!.uid.toString()
    }).whenComplete(() {
      Fluttertoast.showToast(msg: "Request successfully posted");
      Navigator.pop(context);
    }).onError((error, stackTrace) =>
            Fluttertoast.showToast(msg: "Technical Error!!"));
  }
}
