import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
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
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        var data = message.toString();
        print('on message $data');

        var alert = new SimpleDialog(contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          children: <Widget>[



            new InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: new Container(
                height: 50.0,
                decoration: new BoxDecoration(
                  color: Colors.red,
                  border: new Border.all(color: Colors.transparent, width: 0.0),
                  borderRadius: new BorderRadius.circular(0.0),
                ),
                child: new Center(child: new Text(data, style: new TextStyle(fontSize: 18.0, color: Colors.white),),),
              ),
            ),
          ],
        );
        showDialog(context: context, child: alert);

      },
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.getToken().then((token){
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        )
    );
  }
}