import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

class SuggestionsPage extends StatefulWidget {
  SuggestionsPage({Key key}) : super(key: key);
  @override
  _SuggestionsPageState createState() => new _SuggestionsPageState();
}

class _SuggestionsPageState extends State<SuggestionsPage> {
  static const JsonCodec JSON = const JsonCodec();

  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQueryController =
  new TextEditingController();
  final FocusNode _focusNode = new FocusNode();

  bool _isSearching = true;
  String _searchText = "";
  List<String> _searchList = List();
  bool _onTap = false;
  int _onTapTextLength = 0;

  _SuggestionsPageState() {
    _searchQueryController.addListener(() {
      if (_searchQueryController.text.isEmpty) {
        //print("datanya tidak ada");
        setState(() {
          print("datanya tidak ada");
          _isSearching = false;
          _searchText = "";
          _searchList = List();
        });
      } else {
        //print("datanya ada");
        setState(() {
          var dataleng = _searchQueryController.text.length;
          print("datanya ada $dataleng");
          _isSearching = true;
          _searchText = _searchQueryController.text;
          _onTap = _onTapTextLength == _searchText.length;
          //_onTap = _onTapTextLength == dataleng;
//          if(_searchQueryController.text.length > 0){
//            _onTap = true;
//          }else{
//            _onTap = false;
//          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: key,
      appBar: buildAppbar(context),
      body: buildBody(context),
    );
  }

  Widget getFutureWidget() {
    return new FutureBuilder(
        future: _buildSearchList(),
        initialData: List<ListTile>(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ListTile>> childItems) {
          return new Container(
            color: Colors.white,
            height: getChildren(childItems).length * 48.0,
            width: MediaQuery.of(context).size.width,
            child: new ListView(
//            padding: new EdgeInsets.only(left: 50.0),
              children: childItems.data.isNotEmpty
                  ? ListTile
                  .divideTiles(
                  context: context, tiles: getChildren(childItems))
                  .toList()
                  : List(),
            ),
          );
        });
  }

  List<ListTile> getChildren(AsyncSnapshot<List<ListTile>> childItems) {
    if (_onTap && _searchText.length != _onTapTextLength) _onTap = false;
    List<ListTile> childrenList =
    _isSearching && !_onTap ? childItems.data : List();
    return childrenList;
  }

  ListTile _getListTile(String suggestedPhrase) {
    return new ListTile(
      dense: true,
      title: new Text(
        suggestedPhrase,
        style: Theme.of(context).textTheme.body2,
      ),
      onTap: () {
        setState(() {
          _onTap = true;
          _isSearching = false;
          _onTapTextLength = suggestedPhrase.length;
          _searchQueryController.text = suggestedPhrase;
        });
        _searchQueryController.selection = TextSelection
            .fromPosition(new TextPosition(offset: suggestedPhrase.length));
      },
    );
  }

  Future<List<ListTile>> _buildSearchList() async {
    if (_searchText.isEmpty) {
      _searchList = List();
      return List();
    } else {
      print("suggest $_searchText");
      _searchList = await _getSuggestion(_searchText) ?? List();
//        ..add(_searchText);

      List<ListTile> childItems = new List();
      for (var value in _searchList) {
        if (!(value.contains(" ") && value.split(" ").length > 2)) {
          childItems.add(_getListTile(value));
        }
      }
      return childItems;
    }
  }

  Future<List<String>> _getSuggestion(String hintText) async {

    //String url = "SOME_TEST_API?s=$hintText&max=4";
    String url = "https://jsonplaceholder.typicode.com/posts/1?s=$hintText&max=4";

    var response =
    await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

    List decode = JSON.decode(response.body);
    if (response.statusCode != HttpStatus.OK || decode.length == 0) {
      return null;
    }
    List<String> suggestedWords = new List();

    if (decode.length == 0) return null;

    decode.forEach((f) => suggestedWords.add(f["title"]));
//    String data = decode[0]["word"];

    return suggestedWords;
  }

  Widget buildAppbar(BuildContext context) {
    return new AppBar(
      title: new Text('Suggestions Demo'),
    );
  }

  Widget buildBody(BuildContext context) {
    return new SafeArea(
      top: false,
      bottom: false,
      child: new SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: new Stack(
          children: <Widget>[
            new Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 80.0),
                      new TextFormField(
                        controller: _searchQueryController,
                        focusNode: _focusNode,
                        onFieldSubmitted: (String value) {
                          print("$value submitted");
                          setState(() {
                            _searchQueryController.text = value;
                            _onTap = true;
                          });
                        },
                        onSaved: (String value) => print("$value saved"),
                        decoration: const InputDecoration(
                          border: const UnderlineInputBorder(),
                          filled: true,
                          icon: const Icon(Icons.search),
                          hintText: 'Type two words with space',
                          labelText: 'Seach words *',
                        ),
                      ),

                      const SizedBox(height: 40.0),
                      new Center(
                        child: new RaisedButton(
                            color: Colors.orangeAccent,
                            onPressed: () => print("Pressed"),
                            child: const Text(
                              '    Search    ',
                              style: const TextStyle(fontSize: 18.0),
                            )),
                      ),
                      const SizedBox(height: 200.0),
                    ],
                  ),
                ),
              ],
            ),
            new Container(
                alignment: Alignment.topCenter,
                padding: new EdgeInsets.only(
//                  top: MediaQuery.of(context).size.height * .18,
                    top: 136.0,
                    right: 0.0,
                    left: 38.0),
                child: _isSearching && (!_onTap) ? getFutureWidget() : null)
          ],
        ),
      ),
    );
  }
}