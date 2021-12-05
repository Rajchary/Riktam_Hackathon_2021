import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karma/Signup/signup.dart';
import 'package:karma/components/progressdialogue.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    const TextStyle labelStyle = TextStyle(color: Colors.indigo);
    const InputBorder focusBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.indigo, width: 2.0),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8), topRight: Radius.circular(8)),
    );
    const TextStyle inputTextStyle = TextStyle(
        fontSize: 22, color: Colors.indigo, fontStyle: FontStyle.italic);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 150, horizontal: 25),
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
              Text(
                "Signin ",
                style: GoogleFonts.rajdhani(
                  textStyle: Theme.of(context).textTheme.headline4,
                  color: Colors.indigo,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Box(
                size: size,
                inputSize: .045,
              ),
              TextField(
                controller: userName,
                autofocus: true,
                textAlign: TextAlign.center,
                autocorrect: false,
                onChanged: (String value) {
                  (setState(() {
                    if (value == "") {
                      Fluttertoast.showToast(msg: "Name was left empty");
                    }
                  }));
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.indigo,
                  ),
                  labelText: "Username",
                  labelStyle: labelStyle,
                  focusedBorder: focusBorder,
                ),
                style: inputTextStyle,
              ),
              Box(
                size: size,
                inputSize: .05,
              ),
              TextField(
                controller: password,
                autofocus: true,
                textAlign: TextAlign.center,
                autocorrect: false,
                obscureText: true,
                onChanged: (String value) {
                  (setState(() {
                    if (password.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Password was left empty",
                      );
                    }
                  }));
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.indigo,
                  ),
                  labelText: "Pasword",
                  labelStyle: labelStyle,
                  focusedBorder: focusBorder,
                ),
                style: inputTextStyle,
              ),
              Box(
                size: size,
                inputSize: .05,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 15,
                  shadowColor: Colors.grey[600],
                  primary: Colors.indigo[900],
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 25),
                ),
                onPressed: () {
                  if (userName.text.isNotEmpty && password.text.isNotEmpty) {
                    // ignore: unrelated_type_equality_checks
                    if (signinUser(context) == 1) {
                      Fluttertoast.showToast(msg: "Successfully logged in.");
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/Parent', (route) => false);
                    }
                  } else {
                    Fluttertoast.showToast(
                      msg: "Please fill in the details based on the guidlines",
                    );
                  }
                },
                child: Text(
                  "Signin",
                  style: GoogleFonts.rajdhani(
                    textStyle: Theme.of(context).textTheme.headline4,
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Box(
                inputSize: .035,
                size: size,
              ),
              GestureDetector(
                child: Text(
                  "Don't have an account register here",
                  style: GoogleFonts.rajdhani(
                    textStyle: Theme.of(context).textTheme.headline4,
                    color: Colors.blueAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/Signup');
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<int> signinUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const ProgressDialog(
            message: "Validating..",
            color: Colors.blueAccent,
          );
        });
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userName.text.trim(),
        password: password.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "No user found for that email.");
        return 0;
      } else if (e.code == 'wrong-password') {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Wrong password provided for that user.");
        return 0;
      }
    }
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "logged in.");
      Navigator.pushNamedAndRemoveUntil(context, '/Parent', (route) => false);
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "User does not exist.");
      return 0;
    }
    return 1;
  }
}
