import 'package:akar/constants/constants.dart';
import 'package:akar/screens/postsscreen.dart';
import 'package:flutter/material.dart';
import 'package:akar/widgets/Listtilecities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DepartmentScreen extends StatefulWidget {
  @override
  _DepartmentScreenState createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  String ndoc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "شقق للايجار",
          style: bartext2,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: Firestore.instance.collection("شقق للايجار").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text("");
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, num) {
                  DocumentSnapshot ds = snapshot.data.documents[num];
                  return ListTileCities(
                    cityname: ds["city"],
                    goto: () {
                      ndoc = ds["city"];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostsScreen(
                                    namecollection: "شقق للايجار",
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
