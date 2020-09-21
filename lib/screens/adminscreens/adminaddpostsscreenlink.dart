import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  String elmaincat;
  String elcity;
  AddPost({this.elmaincat, this.elcity});
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  bool isimage = true;
  bool radiocon = true;

  final _formkey = GlobalKey<FormState>();
  TextEditingController _post_title = TextEditingController();
  TextEditingController _post_descripition = TextEditingController();
  TextEditingController _post_link = TextEditingController();
  @override
  void dispose() {
    _post_title.dispose();
    _post_descripition.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post from link'),
        actions: <Widget>[],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _post_title,
                    decoration: InputDecoration(
                      hintText: 'العنوان',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Fill Post Title Input';
                      }
                      // return 'Valid Name';
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    controller: _post_descripition,
                    decoration: InputDecoration(
                      hintText: 'التفاصيل',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Fill Description Input';
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    controller: _post_link,
                    decoration: InputDecoration(
                      hintText: 'الرابط',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Fill Description Input';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    title: Text("صورة"),
                    leading: Radio(
                        value: true,
                        groupValue: isimage,
                        onChanged: (val) {
                          setState(() {
                            isimage = val;
                          });
                        }),
                  ),
                  ListTile(
                    title: Text("فيديو"),
                    leading: Radio(
                        value: false,
                        groupValue: isimage,
                        onChanged: (bool val) {
                          setState(() {
                            isimage = val;
                          });
                        }),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'Add Post',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        // add post
                        Firestore.instance
                            .collection('${widget.elmaincat}')
                            .document("${widget.elcity}")
                            .collection("posts")
                            .document()
                            .setData({
                          'title': _post_title.text,
                          'dis': _post_descripition.text,
                          "thereisimgorvid": true,
                          "isimg": isimage,
                          "post_img": _post_link.text
                        });
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
