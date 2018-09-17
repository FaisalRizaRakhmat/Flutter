import 'package:flutter/material.dart';
import 'package:flutter_app_keyboardpopup/ensure_visible_when_focused.dart';

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
      home: new TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => new _TestPageState();
}

class _TestPageState extends State<TestPage> {
  //final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  FocusNode _focusNodeFirstName = new FocusNode();
  FocusNode _focusNodeLastName = new FocusNode();
  FocusNode _focusNodeDescription = new FocusNode();
  static final TextEditingController _firstNameController = new TextEditingController();
  static final TextEditingController _lastNameController = new TextEditingController();
  static final TextEditingController _descriptionController = new TextEditingController();

  List<FocusNode> _focusnd = <FocusNode>[];
  static final List<TextEditingController> _txtEditing = <TextEditingController>[];

  @override
  Widget build(BuildContext context) {

    _focusnd.add(new FocusNode());
    _focusnd.add(new FocusNode());
    _focusnd.add(new FocusNode());
    _txtEditing.add(new TextEditingController());
    _txtEditing.add(new TextEditingController());
    _txtEditing.add(new TextEditingController());

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('My Test Page'),
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          //key: _formKey,
          child: new SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                /* -- Something large -- */
                Container(
                  width: double.infinity,
                  height: 250.0,
                  color: Colors.red,
                ),

                /* -- First Name -- */
                new EnsureVisibleWhenFocused(
                  focusNode: _focusnd.elementAt(0),
                  child:
                  new TextFormField(
                    decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your first name',
                      labelText: 'First name *',
                    ),
                    onSaved: (String value) {
                      //TODO
                    },
                    controller: _txtEditing.elementAt(0),
                    focusNode: _focusnd.elementAt(0)
                  ),
                ),
                const SizedBox(height: 24.0),

                /* -- Last Name -- */
                new EnsureVisibleWhenFocused(
                  focusNode: _focusnd.elementAt(1),
                  child:
                  new TextFormField(
                    decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your last name',
                      labelText: 'Last name *',
                    ),
                    onSaved: (String value) {
                      //TODO
                    },
                    controller: _txtEditing.elementAt(1),
                    focusNode: _focusnd.elementAt(1),
                  ),
                ),
                const SizedBox(height: 24.0),

                /* -- Some other fields -- */
                new Container(
                  width: double.infinity,
                  height: 250.0,
                  color: Colors.blue,
                ),

                /* -- Description -- */
                new EnsureVisibleWhenFocused(
                  focusNode: _focusnd.elementAt(2),
                  child: new TextFormField(
                    decoration: const InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Tell us about yourself',
                      labelText: 'Describe yourself',
                    ),
                    onSaved: (String value) {
                      //TODO
                    },
                    maxLines: 5,
                    controller: _txtEditing.elementAt(2),
                    focusNode: _focusnd.elementAt(2),
                  ),
                ),
                const SizedBox(height: 24.0),

                /* -- Save Button -- */
                new Center(
                  child: new RaisedButton(
                    child: const Text('Save'),
                    onPressed: () {
                      //TODO
                    },
                  ),
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}