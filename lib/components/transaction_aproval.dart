import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Approval extends StatefulWidget {
  const Approval({Key? key}) : super(key: key);

  @override
  _ApprovalState createState() => _ApprovalState();
}

class _ApprovalState extends State<Approval> {
  int approvals = 0;
  List<Map<String, dynamic>> approvalsData = [];
  @override
  void initState() {
    super.initState();
    getApprovalsData();
  }

  Future<void> getApprovalsData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("helpReceived")
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.exists) {
          setState(() {
            ++approvals;
            approvalsData.add(element.data());
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * .055,
                ),
                Text(
                  "Approvals ",
                  style: GoogleFonts.rajdhani(
                    textStyle: Theme.of(context).textTheme.headline4,
                    color: Colors.blue,
                    fontSize: size.width * .065,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (approvals != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: size.height,
                    child: GridView.builder(
                        itemCount: approvals,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: size.width / (size.height / 7)),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.pushNamed(context, '/Approval',
                                    arguments: approvalsData[index]);
                              },
                              child: Container(
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        " ${approvalsData[index]["Name"]}",
                                        style: GoogleFonts.rajdhani(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          color: Colors.blue,
                                          fontSize: size.width * .065,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "₹ ${approvalsData[index]["KarmaPoints"]}",
                                        style: GoogleFonts.rajdhani(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          color: Colors.red,
                                          fontSize: size.width * .065,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                          );
                        }),
                  ),
                if (approvals == 0)
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * .055),
                        Text(
                          "No approvals were made!!",
                          maxLines: 3,
                          style: GoogleFonts.rajdhani(
                            textStyle: Theme.of(context).textTheme.headline4,
                            color: Colors.red,
                            fontSize: size.width * .045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
              ]),
        ),
      ),
    );
  }
}
