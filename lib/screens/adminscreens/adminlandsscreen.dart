import 'package:akar/constants/constants.dart';
import 'package:akar/widgets/adminwidgets/adminListtilecities.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:akar/screens/adminscreens/adminbottomsheet.dart';

import 'adminpostsscreen.dart';

class AdminLandsScreen extends StatefulWidget {
  @override
  _AdminLandsScreenState createState() => _AdminLandsScreenState();
}

class _AdminLandsScreenState extends State<AdminLandsScreen> {
  String ndoc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // add in firebase ;
          showModalBottomSheet(
              context: context,
              builder: (context) => bottomsheetadd(
                    elmaincat: "اراضي جاهزة",
                  ));
        },
        child: Icon(Icons.add),
        backgroundColor: colorpurple3,
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: colorpurple3,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "اراضي للبيع",
          style: bartext2,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: Firestore.instance.collection("اراضي جاهزة").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text("");
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, num) {
                  DocumentSnapshot ds = snapshot.data.documents[num];
                  return AdminListTileCities(
                    cityname: ds["city"],
                    elmaincat: "اراضي جاهزة",
                    goto: () {
                      ndoc = ds["city"];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminPostsScreen(
                                    namecollection: "اراضي جاهزة",
                                    namedocument: ndoc,
                                  )));
                    },
                  );
                },
              );
            }),
      ),
    );
  }
}

/*
                      add cities and posts
                      Firestore.instance.collection("بيوت جاهزة").document().collection("مدينة نصر").document().setData({
                        'post_img': "asd123",
                        'post_price' : 2000,
                      });
                      Firestore.instance.collection("بيوت جاهزة").document().setData({
                        'city': "مدينة نصر"
                      });

 */
