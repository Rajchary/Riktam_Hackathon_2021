import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FetchRequest extends StatefulWidget {
  const FetchRequest({Key? key}) : super(key: key);

  @override
  _FetchRequestState createState() => _FetchRequestState();
}

class _FetchRequestState extends State<FetchRequest> {
  List<Map<String, dynamic>> requestsData = [];
  String pinCode = "";
  int requests = 0;
  @override
  void initState() {
    super.initState();
    getRequests();
  }

  Future<void> getRequests() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          pinCode = value.data()!["pinCode"];
        });
      }
    });
    await FirebaseFirestore.instance
        .collection("requests")
        .where("pinCode", isEqualTo: pinCode)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.exists) {
          if (element.data()["uid"] !=
              FirebaseAuth.instance.currentUser!.uid.toString()) {
            setState(() {
              ++requests;
              requestsData.add(element.data());
            });
          }
        }
      });
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
                Row(
                  children: [
                    SizedBox(
                      width: size.width * .035,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: size.width * .075,
                          color: Colors.blue,
                        )),
                  ],
                ),
                Text(
                  "Requests ",
                  style: GoogleFonts.rajdhani(
                    textStyle: Theme.of(context).textTheme.headline4,
                    color: Colors.blue,
                    fontSize: size.width * .065,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (requests != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: size.height,
                    child: GridView.builder(
                        itemCount: requests,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: size.width / (size.height / 7)),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.pushNamed(context, '/Request',
                                    arguments: requestsData[index]);
                              },
                              child: Container(
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        " ${requestsData[index]["Name"]}",
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
                                        "₹ ${requestsData[index]["karmPoints"]}",
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
                if (requests == 0)
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * .055),
                        Text(
                          "No requests available at the movement!!",
                          maxLines: 3,
                          style: GoogleFonts.rajdhani(
                            textStyle: Theme.of(context).textTheme.headline4,
                            color: Colors.red,
                            fontSize: size.width * .045,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  )
              ]),
        ),
      ),
    );
  }
}
