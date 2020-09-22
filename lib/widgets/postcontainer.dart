import 'package:akar/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostContainer extends StatelessWidget {
  final String linkimg;
  final bool isimage;
  final String title;
  final String discription;
  final bool thereisimgorvid;
  String callnow;
  String whatsapp;
  PostContainer(
      {this.linkimg,
      this.isimage,
      this.title,
      this.discription,
      this.thereisimgorvid});

  Future<dynamic> getData() async {
    Future<DocumentSnapshot> car = Firestore.instance
        .collection('الارقام')
        .document('i9QG86XmVTPKqiDPZlnA')
        .get();
    car.then((carSnapshot) => {
          callnow = carSnapshot["اتصل بنا"],
          whatsapp = carSnapshot['واتس اب'],
        });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Container(
      //style main container
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [colorblue1 , Colors.black]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          thereisimgorvid
              ? LayoutBuilder(
                  builder: (context, constrains) {
                    return Container(
                      // width: MediaQuery.of(context).orientation == Orientation.portrait  ? constrains.maxWidth * 1 : constrains.maxWidth * 1,
                      // height: MediaQuery.of(context).orientation == Orientation.portrait  ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height * 1.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Colors.white38),
                      child: isimage
                          ? MyImg(
                              constrain: constrains,
                              linkmyimg: linkimg,
                            )
                          : MyVideoPlayer(
                              linkvideo: linkimg,
                            ),
                    );
                  },
                )
              : Container(),
          // for images

          // for space = 0.02 of height mobile

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              title == null ? "" : "$title",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 15, right: 15),
            child: Text(
              discription == null ? "" : "$discription",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),

          // for 2 button call now and whatsapp
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // whatsapp button
              FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                onPressed: () async {
                  await FlutterLaunch.launchWathsApp(
                      phone: "+$whatsapp", message: "");
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/whats.png",
                      width: 22,
                      height: 22,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    // Text(
                    //   "الواتس اب",
                    //   style: TextStyle(fontSize: 20, color: Colors.black),
                    // ),
                  ],
                ),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              // call button
              FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                onPressed: () {
                  launch("tel: $callnow");
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.call,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    // Text(
                    //   "اتصل بي",
                    //   style: TextStyle(fontSize: 16, color: Colors.black),
                    // ),
                  ],
                ),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
        ],
      ),
    );
  }
}

class MyVideoPlayer extends StatefulWidget {
  String linkvideo;
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
    _controller = VideoPlayerController.network("${widget.linkvideo}");
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
          return Container(
            child: Center(child: CircularProgressIndicator()),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.35,
          );
        }
      },
    );
  }
}

class MyImg extends StatelessWidget {
  final String linkmyimg;
  final BoxConstraints constrain;
  MyImg({this.linkmyimg, this.constrain});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "$linkmyimg",
      width: constrain.maxWidth,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.35,
      ),
      errorWidget: (context, url, error) => Center(
        child: Text(
          "No Iamges or Videos",
          style: bartext2,
        ),
      ),
    );
  }
}

/*
Image(
      image: NetworkImage(
        "$linkmyimg",
      ),
      width: constrain.maxWidth,
      fit: BoxFit.fill,
      loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null ?
            loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                : null,
          ),
        );
      },
    );
 */
