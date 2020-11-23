import 'dart:io';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:random_string/random_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class AddPostfromgallery extends StatefulWidget {
  String elmaincat;
  String elcity;
  AddPostfromgallery({this.elmaincat, this.elcity});
  @override
  _AddPostfromgalleryState createState() => _AddPostfromgalleryState();
}

class _AddPostfromgalleryState extends State<AddPostfromgallery> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  bool isimage = true;
  bool radiocon = true;
  String _uploadedFileURL;
  File _image;
  bool showspinner = false;
  FirebaseStorage _storage = FirebaseStorage.instance;
  final _formkey = GlobalKey<FormState>();
  TextEditingController _post_title = TextEditingController();
  TextEditingController _post_descripition = TextEditingController();
  DateTime now = DateTime.now();
  // static final DateFormat formatter = DateFormat.yMd().add_jm();
  // final String formatted = formatter.format(now);

  Future chooseFile() async {
    if (isimage) {
      await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
        setState(() {
          _image = image;
        });
      });
    } else {
      await ImagePicker.pickVideo(source: ImageSource.gallery).then((image) {
        setState(() {
          _image = image;
        });
      });
    }
  }

  Future<void> uploadFile() async {
    setState(() {
      showspinner = true;
    });
    String nameimg = randomString(12);
    String fullname = isimage ? "$nameimg.jpeg" : "$nameimg.mp4";
    //Create a reference to the location you want to upload to in firebase
    StorageReference reference = _storage.ref().child("$fullname");

    await reference.putFile(_image).onComplete.then((val) {
      val.ref.getDownloadURL().then((val) {
        _uploadedFileURL = val; //Val here is Already String
      });
    });

    setState(() {
      showspinner = false;
    });

    final snackBar = SnackBar(
      content: Text('File uploaded now you can click in add post'),
      duration: Duration(seconds: 2),
    );
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

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
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Add Post from gallery'),
        actions: <Widget>[],
      ),
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: ListView(
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
                        hintText: 'Post Title',
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
                      maxLines: 5,
                      controller: _post_descripition,
                      decoration: InputDecoration(
                        hintText: 'Description',
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
                    isimage
                        ? _image == null
                            ? Text("no image")
                            : Image.file(_image)
                        : _image == null
                            ? Text("no video")
                            : MyVideoPlayer(
                                linkvideo: _image,
                              ),
                    RaisedButton(
                      color: Colors.grey,
                      child: Text(
                        isimage ? "get image" : "get video",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        chooseFile();
                      },
                    ),
                    RaisedButton(
                      color: Colors.grey,
                      child: Text(
                        isimage ? "upload image" : "upload video",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        uploadFile();
                      },
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'Add Post',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
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
                            "post_img": _uploadedFileURL,
                            "time": now.millisecondsSinceEpoch,
                          });
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyVideoPlayer extends StatefulWidget {
  File linkvideo;
  MyVideoPlayer({Key key, this.linkvideo}) : super(key: key);
  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.linkvideo);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(0.5);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GestureDetector(
            onTap: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              });
            },
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
