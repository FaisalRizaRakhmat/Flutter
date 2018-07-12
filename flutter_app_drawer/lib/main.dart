import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      drawer: new AppDrawer(), // left side
      //endDrawer: new AppDrawer(), // right side
      appBar: new AppBar(
        title: new Text("Title"),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new Text("Body"),
          ),
          new ListTile(
            title: new RaisedButton(
              child: new Text("Open Drawer"),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer(); // left side
                //_scaffoldKey.currentState.openEndDrawer(); // right side
              },
            ),
          ),
        ],
      ),
    );
  }
}


class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => new _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          const DrawerHeader(child: const Center(child: const Text('Stocks'))),
          const ListTile(
            leading: const Icon(Icons.assessment),
            title: const Text('Stock List'),
            selected: true,
          ),
          const ListTile(
            leading: const Icon(Icons.account_balance),
            title: const Text('Account Balance'),
            enabled: false,
          ),
          new ListTile(
            leading: const Icon(Icons.dvr),
            title: const Text('Dump App to Console'),
            onTap: () {
              try {
                debugDumpApp();
                debugDumpRenderTree();
                debugDumpLayerTree();
                //debugDumpSemanticsTree(DebugSemanticsDumpOrder.traversalOrder);
              } catch (e, stack) {
                debugPrint('Exception while dumping app:\n$e\n$stack');
              }
            },
          ),
          const Divider(),
          new ListTile(
            leading: const Icon(Icons.thumb_up),
            title: const Text('Optimistic'),
//            trailing: new Radio<StockMode>(
//              value: StockMode.optimistic,
//              groupValue: widget.configuration.stockMode,
//              onChanged: _handleStockModeChange,
//            ),
            onTap: () {
              //_handleStockModeChange(StockMode.optimistic);
            },
          ),
          new ListTile(
            leading: const Icon(Icons.thumb_down),
            title: const Text('Pessimistic'),
//            trailing: new Radio<StockMode>(
//              value: StockMode.pessimistic,
//              groupValue: widget.configuration.stockMode,
//              onChanged: _handleStockModeChange,
//            ),
            onTap: () {
              //_handleStockModeChange(StockMode.pessimistic);
            },
          ),
          const Divider(),
          new ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            //onTap: _handleShowSettings,
          ),
          new ListTile(
            leading: const Icon(Icons.help),
            title: const Text('About'),
            //onTap: _handleShowAbout,
          ),
        ],
      ),
    );
  }
}