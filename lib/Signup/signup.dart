import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karma/components/progressdialogue.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController psdController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController pscodeController = TextEditingController();
  String gender = "NA";
  bool isFilled = true;
  void showToast(String msg, Color color) {
    Fluttertoast.showToast(
        msg: msg, textColor: color, gravity: ToastGravity.BOTTOM, fontSize: 15);
  }

  bool finalValidation() {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (nameController.text == "")
      // ignore: curly_braces_in_flow_control_structures
      return false;
    else if (emailController.text == "" ||
        emailController.text.split("@").length != 2)
      // ignore: curly_braces_in_flow_control_structures
      return false;
    else if (!regExp.hasMatch(psdController.text))
      // ignore: curly_braces_in_flow_control_structures
      return false;
    else if (mobileController.text.length != 10)
      // ignore: curly_braces_in_flow_control_structures
      return false;
    else if (pscodeController.text.length != 6)
      // ignore: curly_braces_in_flow_control_structures
      return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const TextStyle labelStyle = TextStyle(color: Colors.purple);
    const InputBorder focusBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.purple, width: 2.0),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8), topRight: Radius.circular(8)),
    );
    const TextStyle inputTextStyle = TextStyle(
        fontSize: 22, color: Colors.purple, fontStyle: FontStyle.italic);

    String name, email, password, mobile, postalCode;
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 80,
          bottom: 100,
        ),
        child: Container(
          height: size.height,
          width: size.width * .9,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Signup ",
                  style: GoogleFonts.rajdhani(
                    textStyle: Theme.of(context).textTheme.headline4,
                    color: Colors.purple,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Box(
                  size: size,
                  inputSize: .025,
                ),
                TextField(
                  controller: nameController,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  autocorrect: false,
                  onChanged: (String value) {
                    (setState(() {
                      name = value;
                      if (value == "") {
                        showToast("Name was left empty", Colors.red);
                        isFilled = false;
                      }
                    }));
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.purple,
                    ),
                    labelText: "Name",
                    labelStyle: labelStyle,
                    focusedBorder: focusBorder,
                  ),
                  style: inputTextStyle,
                ),
                Box(
                  size: size,
                  inputSize: .035,
                ),
                TextField(
                  controller: emailController,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  autocorrect: false,
                  onChanged: (String value) {
                    (setState(() {
                      email = value;
                      if (email == "") {
                        showToast("Email was left empty", Colors.red);
                      }
                    }));
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.mail_outline_sharp,
                      color: Colors.purple,
                    ),
                    labelText: "Email",
                    labelStyle: labelStyle,
                    focusedBorder: focusBorder,
                  ),
                  style: inputTextStyle,
                ),
                Box(
                  size: size,
                  inputSize: .035,
                ),
                TextField(
                  controller: psdController,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  autocorrect: false,
                  obscureText: true,
                  onChanged: (String value) {
                    (setState(() {
                      password = value;
                      if (password == "") {
                        showToast("Password was left empty", Colors.red);
                      }
                    }));
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.purple,
                    ),
                    labelText: "Pasword",
                    labelStyle: labelStyle,
                    focusedBorder: focusBorder,
                  ),
                  style: inputTextStyle,
                ),
                Box(
                  size: size,
                  inputSize: .035,
                ),
                TextField(
                  controller: mobileController,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  autocorrect: false,
                  keyboardType: const TextInputType.numberWithOptions(),
                  onChanged: (String value) {
                    (setState(() {
                      mobile = value;
                    }));
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.purple,
                    ),
                    labelText: "Mobile",
                    labelStyle: labelStyle,
                    focusedBorder: focusBorder,
                  ),
                  style: inputTextStyle,
                ),
                Box(
                  size: size,
                  inputSize: .035,
                ),
                TextField(
                  controller: pscodeController,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  autocorrect: false,
                  keyboardType: const TextInputType.numberWithOptions(),
                  onChanged: (String value) {
                    (setState(() {
                      postalCode = value;
                    }));
                  },
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.gps_fixed_outlined,
                        color: Colors.purple,
                      ),
                      labelText: "Postal Code",
                      labelStyle: labelStyle,
                      focusedBorder: focusBorder),
                  style: inputTextStyle,
                ),
                Box(
                  size: size,
                  inputSize: .035,
                ),
                DropdownButton<String>(
                  value: gender,
                  icon: const Icon(
                    Icons.arrow_downward,
                    color: Colors.purple,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.purple),
                  underline: Container(
                    height: 2.5,
                    color: Colors.purple,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      gender = newValue!;
                    });
                  },
                  items: <String>['NA', 'Male', 'Female']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 15,
                        shadowColor: Colors.grey[600],
                        primary: Colors.purple[400],
                        padding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 25),
                      ),
                      onPressed: () {
                        isFilled = finalValidation();
                        if (isFilled) {
                          // ignore: unrelated_type_equality_checks
                          if (registerNewUser(context) == "Success") {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/Parent', (route) => false);
                          }
                        } else {
                          showToast(
                              "Please fill in the details based on the guidlines",
                              Colors.red);
                        }
                      },
                      child: Text(
                        "Signup",
                        style: GoogleFonts.rajdhani(
                          textStyle: Theme.of(context).textTheme.headline4,
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Box(
                  inputSize: .035,
                  size: size,
                ),
                GestureDetector(
                  child: Text(
                    "Already have an account login here",
                    style: GoogleFonts.rajdhani(
                      textStyle: Theme.of(context).textTheme.headline4,
                      color: Colors.deepPurple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/Login');
                  },
                )
              ]),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  Future<String> registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ProgressDialog(
            message: "Registering..",
            color: Colors.purple,
          );
        });
    UserCredential firebaseUser;
    bool user = false;
    try {
      firebaseUser = await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text, password: psdController.text);
      user = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
        Navigator.pop(context);
        return "Failed";
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
        Navigator.pop(context);
        return "Failed";
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error Occured");
      Navigator.pop(context);
      return "Failed";
    }

    if (user) {
      DocumentReference documentReferencer =
          userCollection.doc(FirebaseAuth.instance.currentUser!.uid);
      documentReferencer.set({
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "password": psdController.text.trim(),
        "mobile": mobileController.text.trim(),
        "pinCode": pscodeController.text.trim(),
        "KarmaPoints": 100,
        "gender": gender,
      }).then((value) {
        Fluttertoast.showToast(msg: "Successfully registered");
        Navigator.pushNamedAndRemoveUntil(context, '/Parent', (route) => false);
        return "Success";
      }).catchError((error) {
        Fluttertoast.showToast(msg: "Please try after some time");
        return "Failed";
      });
    }
    Navigator.pop(context);
    return "Success";
  }
}

class Box extends StatelessWidget {
  const Box({Key? key, required this.size, required this.inputSize})
      : super(key: key);

  final Size size;
  final double inputSize;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * inputSize,
    );
  }
}
