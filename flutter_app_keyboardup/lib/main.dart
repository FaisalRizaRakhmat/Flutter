import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animation Demo',
      theme: new ThemeData(
        primaryColor: new Color(0xFFFF0000),
      ),
      home: new FormDemo(),
    );
  }
}

class FormDemo extends StatefulWidget {
  @override
  _FormDemoState createState() => _FormDemoState();
}

class _FormDemoState extends State<FormDemo> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  TextEditingController textde =new TextEditingController();


  FocusNode _focusNode = FocusNode();
  GlobalKey<EditableTextState> _inputKey = new GlobalKey<EditableTextState>();


  @override
  void initState() {
    super.initState();




    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 300.0, end: 50.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.forward();
        var cursorPos = textde.selection;

        textde.text = "test" ?? '';

        if (cursorPos.start > textde.text.length) {
          cursorPos = new TextSelection.fromPosition(new TextPosition(offset: textde.text.length));
        }
        var pos = cursorPos.extentOffset.toInt();
        print("position $pos");
        textde.selection = cursorPos;
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

//    var heig = _inputKey.current.size.height;
//    print("height $heig");

//    return Scaffold(
//      //resizeToAvoidBottomPadding: false, // this avoids the overflow error
//      appBar: AppBar(
//        title: Text('TextField Animation Demo'),
//      ),
//      body:  Container(
//          padding: const EdgeInsets.all(20.0),
//          child: Column(
//            children: <Widget>[
//              SizedBox(height: _animation.value-50.0),
//              TextFormField(
//                decoration: InputDecoration(
//                  labelText: 'I move!',
//                ),
//                key : _inputKey,
//                focusNode: _focusNode,
//              ),
//              TextFormField(
//                decoration: InputDecoration(
//                  labelText: 'I move!',
//                ),
//                key : _inputKey,
//                focusNode: _focusNode,
//              ),
//              TextFormField(
//                decoration: InputDecoration(
//                  labelText: 'I move!',
//                ),
//                key : _inputKey,
//                focusNode: _focusNode,
//              ),
//              SizedBox(height: 20.0),
//              new Container(
//                height: 50.0,
//                width: MediaQuery.of(context).size.width,
//                color: Colors.red,
//                child:
//                      new InkWell(
//                        highlightColor: Colors.brown,
//                        onTap: () {
//                          FocusScope.of(context).requestFocus(FocusNode());
//                        },
//                        splashColor: Colors.red,
//                        child: new Text("button"),
//                      )
//              ,)
////              SizedBox(height: _animation.value),
//            ],
//          ),
//        ),
//    );

    return Scaffold(
      resizeToAvoidBottomPadding: false, // this avoids the overflow error
      appBar: AppBar(
        title: Text('TextField Animation Demo'),
      ),
      body: new InkWell( // to dismiss the keyboard when the user tabs out of the TextField
        splashColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: _animation.value),
              new TextField(
                controller: textde,
                focusNode: _focusNode,
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.only(top: 0.0,bottom: 0.0),
                  filled: true,
                  fillColor: Colors.transparent,
                  //hintText: 'Please enter OTP SMS in here',
                  labelText: "Tezt",
                  labelStyle: const TextStyle(color: Colors.white),
                  hintStyle: const TextStyle(color: Colors.white),
                ),
              ),
              TextFormField(
                controller: textde,
                decoration: InputDecoration(
                  labelText: 'I move!',
                ),
                autofocus: true,
                focusNode: _focusNode,
              ),
              TextFormField(
                controller: textde,
                decoration: InputDecoration(
                  labelText: 'I move!',
                ),
                focusNode: _focusNode,
              ),
              TextFormField(
                controller: textde,
                decoration: InputDecoration(
                  labelText: 'I move!',
                ),
                focusNode: _focusNode,
              )
            ],
          ),
        ),
      ),
    );
  }
}