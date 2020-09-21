import 'package:akar/constants/constants.dart';
import 'package:akar/screens/adminscreens/adminaddpostsscreengallery.dart';
import 'package:flutter/material.dart';
import 'package:akar/screens/adminscreens/adminaddpostsscreenlink.dart';

import 'adminaddpostwithout.dart';

class AdminToAdd extends StatelessWidget {
  final String namecollection;
  final String namedocument;
  AdminToAdd({this.namedocument, this.namecollection});
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
          "$namedocument",
          style: bartext2,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddPost(
                                elmaincat: namecollection,
                                elcity: namedocument,
                              )));
                },
                child: Text(
                  "اضافة موضوع الصورة او الفيديو من رابط",
                  style: bartext2,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddPostfromgallery(
                                elmaincat: namecollection,
                                elcity: namedocument,
                              )));
                },
                child: Text(
                  "اضافة موضوع الصورة او الفيديو من الهاتف",
                  style: bartext2,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddpostsWithout(
                                elmaincat: namecollection,
                                elcity: namedocument,
                              )));
                },
                child: Text(
                  "اضافة مواضيع بدون صورة او فيديو",
                  style: bartext2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
