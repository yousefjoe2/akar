import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:akar/constants/constants.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AdminListTileCities extends StatelessWidget {
  final String cityname;
  final String elmaincat;
  final Function goto;
  AdminListTileCities({this.cityname, this.goto, this.elmaincat});
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionExtentRatio: 0.25,
      actionPane: SlidableDrawerActionPane(),
      actions: [
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            // will delete in firebase
            Firestore.instance
                .collection("$elmaincat")
                .document("$cityname")
                .delete();
            Firestore.instance
                .collection("$elmaincat")
                .document("$cityname")
                .collection("posts")
                .getDocuments()
                .then((snapshot) {
              for (DocumentSnapshot doc in snapshot.documents) {
                doc.reference.delete();
              }
            });
          },
        ),
      ],
      child: ListTile(
        trailing: Text(
          "$cityname",
          style: headtext1,
        ),
        onTap: goto,
      ),
    );
  }
}
