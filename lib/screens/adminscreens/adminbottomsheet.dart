import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class bottomsheetadd extends StatelessWidget {
  Key _k1 = GlobalKey();
  String newcity;
  final String elmaincat;
  final controltextfield = TextEditingController();
  bottomsheetadd({this.elmaincat});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Text(
                "اضافة فئة",
                style: TextStyle(color: Colors.blue, fontSize: 25),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: TextFormField(
                  autofocus: true,
                  onFieldSubmitted: (value) {
                    newcity = value;
                    Firestore.instance
                        .collection("$elmaincat")
                        .document(newcity)
                        .setData({
                      "city": newcity,
                    });
                    Navigator.pop(context);
                  },
                  controller: controltextfield,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
      ),
    );
  }
}
