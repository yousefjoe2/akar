import 'package:akar/widgets/adminwidgets/adminpostcontainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:akar/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:akar/screens/adminscreens/admintoadd.dart';

import 'adminaddpostsscreenlink.dart';

class AdminPostsScreen extends StatelessWidget {
  final String namecollection;
  final String namedocument;
  AdminPostsScreen({this.namecollection, this.namedocument});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminToAdd(
                        namedocument: namedocument,
                        namecollection: namecollection,
                      )));
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
          "$namedocument",
          style: bartext2,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: StreamBuilder(
            stream: Firestore.instance
                .collection("$namecollection")
                .document("$namedocument")
                .collection("posts")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text("loading");
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, num) {
                  DocumentSnapshot ds = snapshot.data.documents[num];
                  return AdminPostContainer(
                    linkimg: ds["post_img"],
                    isimage: ds["isimg"],
                    title: ds["title"],
                    discription: ds["dis"],
                    elmaincat: namecollection,
                    elcity: namedocument,
                    id: ds.documentID,
                    thereisimgorvid: ds["thereisimgorvid"],
                  );
                },
              );
            }),
      ),
    );
  }
}

/*
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20) , topRight: Radius.circular(20)),
                  child: Image.asset("assets/images/houses3.jpg" , width: constraints.maxWidth ,fit: BoxFit.fill,),
                )
 */
