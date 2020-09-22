import 'package:akar/screens/prefabscreen.dart';
import 'package:flutter/material.dart';
import 'package:akar/constants/constants.dart';
import 'package:akar/widgets/expandedhomescreen.dart';
import 'package:akar/screens/departmentscreen.dart';
import 'package:akar/screens/landsscreen.dart';
import 'package:akar/screens/adminscreens/adminlogin.dart';

class HomeScreen extends StatelessWidget {
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

        //this action for setting icon to log in as admin and can modify in posts and cities
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings,
                color: colorpurple3,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminLogin()));
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          children: [
            // Expanded home screen it is wigdet in widget to use in home screen to go to anthor pages
            // this is for بيوت جاهزة
            ExpandedHomeScreen(
              name: "بيوت جاهزة",
              img: "prefab.png",
              widnumb: 0.8,

              goto: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrefabScreen()),
                );
              },
            ),
            SizedBox(
              height: 25,
            ),
            // this expanded to put in it 2 expanded home screen اراضي للبيع و شقق للايجار
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
                              builder: (context) => LandsScreen()),
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
                              builder: (context) => DepartmentScreen()),
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
