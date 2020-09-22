import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'package:akar/constants/constants.dart';

class SplashToHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Colors.white,
      seconds: 3,
      navigateAfterSeconds: HomeScreen(),
      image: Image.asset("assets/images/splash3.png"),
      title: Text("عقار عرعر يرحب بكم" , style: TextStyle(color: colorpurple3 , fontSize: 35 , fontFamily: "shoroq"),),
      photoSize: 100,
      loaderColor: colorblue3,
      loadingText: Text("Loading Now", style: TextStyle(color: colorpurple3 , fontSize: 35),),

    );
  }
}

