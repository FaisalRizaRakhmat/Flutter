import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new CorrectWrongOverlay(true,50.0,50.0,null),
    );
  }
}

class CorrectWrongOverlay extends StatefulWidget {
  final bool _isCorrect;
  final VoidCallback _onTap;
  final double percentR;
  final double percentW;

  CorrectWrongOverlay(
      this._isCorrect, this.percentR, this.percentW, this._onTap);

  @override
  State createState() => new CorrectWrongOverlayState();
}

class CorrectWrongOverlayState extends State<CorrectWrongOverlay>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        duration: new Duration(seconds: 2), vsync: this);
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.linear);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  void dispose() {
    //_iconAnimationController.dispose();
    super.dispose();
  }

  bool _disableTopTapDetector = false;

  @override
  Widget build(BuildContext context) {

    return new Stack(children: [
      new GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => setState(() {
            print('bottom tapped!');
            _disableTopTapDetector = false;
          })),
      new GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: _disableTopTapDetector
              ? null
              : () => setState(() {
            print('top tapped!');
            _disableTopTapDetector = true;
          }))
    ]);

//    return new Material(
//      color: Colors.black54,
//      child: new InkWell(
//        onTap: () => widget._onTap(),
//        child: new Padding(
//          padding: const EdgeInsets.all(0.0),
//          child:
////          new Center(
////            child:
//            new Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.end,
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                new Padding(
//                  padding: const EdgeInsets.all(0.0),
//                  child: new Container(
//                    width: 80.0,
//                    height: 200.0 * _iconAnimation.value,
//                    color: Colors.green,
//                  ),
//                ),
////                new Padding(
////                  padding: const EdgeInsets.all(8.0),
////                  child: new Container(
////                    width: 80.0,
////                    height: 200.0,
////                    color: Colors.green,
////                  ),
////                )
//              ],
//            ),
//          //),
//        ),
//      ),
//    );
  }
}