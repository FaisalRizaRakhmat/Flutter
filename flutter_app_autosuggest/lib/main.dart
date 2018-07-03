import 'package:flutter/material.dart';
import 'package:flutter_app_autosuggest/suggestions_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Suggestions Demo',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.orange,
      ),
      home: new SuggestionsPage(),
    );
  }
}