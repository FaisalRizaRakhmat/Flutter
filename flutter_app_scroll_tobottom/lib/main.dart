import 'dart:collection';

import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Example',
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> _messages = <Widget>[new Text('hello'), new Text('world')];
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Container(
          decoration: new BoxDecoration(color: Colors.blueGrey.shade100),
          width: 100.0,
          height: 100.0,
          child: new Column(
            children: [
              new Flexible(
                child: new ListView(
                  controller: _scrollController,
                  reverse: true,
                  shrinkWrap: true,
                  children: new UnmodifiableListView(_messages),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () {
            setState(() {
              _messages.insert(0, new Text("message ${_messages.length}"));
            });
            _scrollController.animateTo(
              0.0,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
            );
          }
      ),
    );
  }
}