import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karma/main.dart';

class Splash extends StatefulWidget {
  static const String idScreen = "splash_screen";
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateHome();
  }

  _navigateHome() async {
    await Future.delayed(const Duration(milliseconds: 5000), () {});
    FirebaseAuth.instance.currentUser == null
        ? Navigator.pushNamedAndRemoveUntil(context, '/Login', (route) => false)
        : Navigator.pushNamedAndRemoveUntil(
            context, '/Parent', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/journey.svg",
              height: size.height * .21,
              width: size.width * .25,
            ),
            SizedBox(
              height: size.height * .09,
            ),
            DefaultTextStyle(
              style: GoogleFonts.lobster(
                textStyle: Theme.of(context).textTheme.headline4,
                color: Colors.indigo,
                fontSize: 55,
                fontWeight: FontWeight.bold,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('Karma'),
                ],
                isRepeatingAnimation: true,
              ),
            ),
            SizedBox(
              height: size.height * .015,
            ),
            SizedBox(
              width: 250.0,
              child: DefaultTextStyle(
                style: GoogleFonts.rajdhani(
                  textStyle: Theme.of(context).textTheme.headline4,
                  color: Colors.purple,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('Making today a perfect day...'),
                    TypewriterAnimatedText('What goes around comes around...'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
