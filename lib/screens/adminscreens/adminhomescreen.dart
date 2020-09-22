import 'package:akar/screens/adminscreens/adminprefabscreen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:akar/constants/constants.dart';
import 'package:akar/widgets/expandedhomescreen.dart';
import 'package:akar/screens/adminscreens/admindepartmentscreen.dart';
import 'package:akar/screens/adminscreens/adminlandsscreen.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "عقار عرعر",
          style: bartext1,
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: colorpurple3,
              size: 30,
            ),
            onPressed: () async {
              Navigator.pop(context);
              await FirebaseAuth.instance.signOut();
            }),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            ExpandedHomeScreen(
              name: "بيوت جاهزة",
              img: "prefab.png",
              widnumb: 0.8,

              goto: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPrefabScreen()),
                );
              },
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ExpandedHomeScreen(
                      name: "اراضي للبيع",
                      img: "lands.png",
                      widnumb: 0.4,

                      goto: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminLandsScreen()),
                        );
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ExpandedHomeScreen(
                      name: "شقق للايجار",
                      img: "department2.png",
                      widnumb: 0.30,

                      goto: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminDepartmentScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
