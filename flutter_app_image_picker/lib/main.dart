import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:video_player/video_player.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Image Picker Demo',
      home: new MyHomePage(title: 'Image Picker Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Image Picker Example'),
      ),
      body: new Center(
        child: _image == null
            ? new Text('No image selected.')
            : new Image.file(_image),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}

//class AspectRatioVideo extends StatefulWidget {
//  final VideoPlayerController controller;
//
//  AspectRatioVideo(this.controller);
//
//  @override
//  AspectRatioVideoState createState() => new AspectRatioVideoState();
//}
//
//class AspectRatioVideoState extends State<AspectRatioVideo> {
//  VideoPlayerController get controller => widget.controller;
//  bool initialized = false;
//
//  VoidCallback listener;
//
//  @override
//  void initState() {
//    super.initState();
//    listener = () {
//      if (!mounted) {
//        return;
//      }
//      if (initialized != controller.value.initialized) {
//        initialized = controller.value.initialized;
//        setState(() {});
//      }
//    };
//    controller.addListener(listener);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    if (initialized) {
//      final Size size = controller.value.size;
//      return new Center(
//        child: new AspectRatio(
//          aspectRatio: size.width / size.height,
//          child: new VideoPlayer(controller),
//        ),
//      );
//    } else {
//      return new Container();
//    }
//  }
//}
