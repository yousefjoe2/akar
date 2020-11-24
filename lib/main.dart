import 'package:flutter/material.dart';
import 'package:akar/screens/homescreen.dart';
import 'package:akar/screens/splashscreen.dart';

/*
* Made By YousefFathi
* Start in 16 /9 /2020
* end in 22 /9 /2020
* back end Firebase
* for android and ios
* updated in 24/11/2020
* akar 3r3r
*
 */

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      /*
      this homescreen made for all users and to join as admin you can join by setting icon in appbar
       */
      home: SplashToHome(),
    );
  }
}
