import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:akar/constants/constants.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListTileCities extends StatelessWidget {
  final String cityname;
  final String elmaincat;
  final Function goto;
  ListTileCities({this.cityname, this.goto, this.elmaincat});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Text(
        "$cityname",
        style: headtext1,
      ),
      onTap: goto,
    );
  }
}
