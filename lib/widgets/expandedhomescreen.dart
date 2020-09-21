import 'package:flutter/material.dart';
import 'package:akar/constants/constants.dart';

class ExpandedHomeScreen extends StatelessWidget {
  final String name;
  final String img;
  final double widnumb;
  final Function goto;
  ExpandedHomeScreen({this.name, this.img, this.widnumb, this.goto});
  @override
  Widget build(BuildContext context) {
    var deviceinfo = MediaQuery.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: goto,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [colorpurple2, colorblue1]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "$name",
                      style: headtext1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Image.asset("assets/images/$img.png"),
                      constraints: BoxConstraints(
                          maxWidth: deviceinfo.size.width * widnumb),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
