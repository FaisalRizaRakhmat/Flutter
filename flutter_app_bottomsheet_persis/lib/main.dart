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
      home: new PersistentBottomSheetDemo(),
    );
  }
}

class PersistentBottomSheetDemo extends StatefulWidget {
  static const String routeName = '/material/persistent-bottom-sheet';

  @override
  _PersistentBottomSheetDemoState createState() => new _PersistentBottomSheetDemoState();
}

class _PersistentBottomSheetDemoState extends State<PersistentBottomSheetDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  VoidCallback _showBottomSheetCallback;

  @override
  void initState() {
    super.initState();
    _showBottomSheetCallback = _showBottomSheet;
  }

  void _showBottomSheet() {
    setState(() { // disable the button
      _showBottomSheetCallback = null;
    });
    _scaffoldKey.currentState.showBottomSheet<Null>((BuildContext context) {
      final ThemeData themeData = Theme.of(context);
      return new Container(
        height: 200.0,
          decoration: new BoxDecoration(
              border: new Border(top: new BorderSide(color: themeData.disabledColor))
          ),
          child: new Padding(

              padding: const EdgeInsets.all(32.0),
              child: new Text('This is a Material persistent bottom sheet. Drag downwards to dismiss it.',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: themeData.accentColor,
                      fontSize: 24.0
                  )
              )
          )
      );
    })
        .closed.whenComplete(() {
      if (mounted) {
        setState(() { // re-enable the button
          _showBottomSheetCallback = _showBottomSheet;
        });

      }
    });
  }

  void _showMessage() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          content: const Text('You tapped the floating action button.'),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK')
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(title: const Text('Persistent bottom sheet')),
        floatingActionButton: new FloatingActionButton(
          onPressed: _showMessage,
          backgroundColor: Colors.redAccent,
          child: const Icon(
            Icons.add,
            semanticLabel: 'Add',
          ),
        ),
        body: new Center(
            child: new RaisedButton(
                onPressed: _showBottomSheetCallback,
                child: const Text('SHOW BOTTOM SHEET')
            )
        )
    );
  }
}