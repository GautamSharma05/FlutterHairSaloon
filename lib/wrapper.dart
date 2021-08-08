import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/LoginScreen.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Color(0xFF001B40),
      splash: 'assets/images/logo.png',
      nextScreen: FirebaseAuth.instance.currentUser == null
          ? LoginScreen()
          : HomeScreen(),
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
