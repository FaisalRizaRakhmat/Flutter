import 'package:flutter/material.dart';

import 'package:flutter_buttons/flutter_buttons.dart';

void main() => runApp(FlutterButtonsDemo());

class FlutterButtonsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buttons Demo',
      theme: ThemeData(primaryColor: Colors.red),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Buttons Demo'),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
//              KRaisedButton(
//                radius: 30.0,
//                color: Colors.teal,
//                text: 'Raised Button',
//                textColor: Colors.white,
//                textFontWeight: FontWeight.bold,
//                onPressed: () => {},
//              ),
              KOutlineButton(
                radius: 30.0,
                borderColor: Colors.red,
                text: 'Outline Button',
                textColor: Colors.red,
                textFontWeight: FontWeight.bold,
                onPressed: () => {},
              ),
//              KFlatButton(
//                radius: 30.0,
//                color: Colors.teal,
//                text: 'Flat Button',
//                textColor: Colors.white,
//                textFontWeight: FontWeight.bold,
//                onPressed: () => {},
//              ),
//              GradientButton(
//                buttonColorGradient: [
//                  Colors.teal.shade100,
//                  Colors.teal.shade900
//                ],
//                buttonBorderColor: Colors.teal,
//                buttonText: 'Gradient button',
//                buttonTextColor: Colors.white,
//                highlightColor: Colors.white30,
//                splashColor: Colors.white,
//                onPressed: () {},
//              ),
//              SelectedButton(
//                radius: 30.0,
//                unselectedButtonColor: Colors.white,
//                selectedButtonColor: Colors.teal,
//                text: 'Selected Button',
//                unselectedTextColor: Colors.teal,
//                selectedTextColor: Colors.white,
//                textFontWeight: FontWeight.bold,
//                iconData: Icons.email,
//                unselectedIconColor: Colors.teal,
//                selectedIconColor: Colors.white,
//                onPressed: () {},
//              ),
            ],
          ),
        ),
      ),
    );
  }
}
