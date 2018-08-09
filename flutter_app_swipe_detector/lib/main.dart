import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  String _swipeDirection = "";
  double height_ww = 250.0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: new AnimatedSize(
        curve: Curves.fastOutSlowIn,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Center(child:
            new Container(
              width: 300.0,
              height: height_ww,
              child:
              SwipeDetector(
                child: Card(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 80.0,
                      bottom: 80.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Swipe Me!',
                          style: TextStyle(
                            fontSize: 40.0,
                          ),
                        ),
                        Text(
                          '$_swipeDirection',
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ),
                ),

                onSwipeUp: () {
                  setState(() {
                    _swipeDirection = "Swipe Up";
                    height_ww = 400.0;
                  });
                },
                onSwipeDown: () {
                  setState(() {
                    _swipeDirection = "Swipe Down";
                    height_ww = 250.0;
                  });
                },
                onSwipeLeft: () {
                  setState(() {
                    _swipeDirection = "Swipe Left";
                  });
                },
                onSwipeRight: () {
                  setState(() {
                    _swipeDirection = "Swipe Right";
                  });
                },
                swipeConfiguration: SwipeConfiguration(
                    verticalSwipeMinVelocity: 100.0,
                    verticalSwipeMinDisplacement: 50.0,
                    verticalSwipeMaxWidthThreshold:100.0,
                    horizontalSwipeMaxHeightThreshold: 50.0,
                    horizontalSwipeMinDisplacement:50.0,
                    horizontalSwipeMinVelocity: 200.0),
              ),

            ),
            ),
          ],
        ),
        vsync: this, duration: new Duration(seconds: 2),
      )

    );
  }
}