import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController textEditingControllerUrl = new TextEditingController();
  TextEditingController textEditingControllerId = new TextEditingController();

  @override
  initState() {
    super.initState();

  }

  void playYoutubeVideo() {
    FlutterYoutube.playYoutubeVideoByUrl(
      apiKey: "AIzaSyAkT6S8cnP_5KLKjSJxhDz7lcOwm6U2tMM",
      videoUrl: "https://www.youtube.com/watch?v=fhWaJi1Hsfo",
      fullScreen: false
    );
  }

  void playYoutubeVideoEdit() {
    FlutterYoutube.playYoutubeVideoByUrl(
      apiKey: "AIzaSyAkT6S8cnP_5KLKjSJxhDz7lcOwm6U2tMM",
      videoUrl: textEditingControllerUrl.text,
    );
  }
  void playYoutubeVideoIdEdit() {
    FlutterYoutube.playYoutubeVideoById(
      apiKey: "AIzaSyAkT6S8cnP_5KLKjSJxhDz7lcOwm6U2tMM",
      videoId: textEditingControllerId.text,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Youtube Player'),
        ),
        body: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextField (
                  controller: textEditingControllerUrl,
                  decoration: new InputDecoration(
                      labelText: "Enter Youtube URL"
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(
                    child: new Text("Play Video By Url"),
                    onPressed: playYoutubeVideoEdit
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(
                    child: new Text("Play Default Video"),
                    onPressed: playYoutubeVideo
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextField (
                  controller: textEditingControllerId,
                  decoration: new InputDecoration(
                      labelText: "Youtube Video Id (fhWaJi1Hsfo)"
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(
                    child: new Text("Play Video By Id"),
                    onPressed: playYoutubeVideoIdEdit
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}