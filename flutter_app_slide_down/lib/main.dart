import 'package:flutter/material.dart';

class DayPickerBar extends StatefulWidget {
  DayPickerBar({ this.selectedDate, this.onChanged });

  final DateTime selectedDate;

  final ValueChanged<DateTime> onChanged;

  DayPickerBarState createState() => new DayPickerBarState();
}

class DayPickerBarState extends State<DayPickerBar> {
  DateTime _displayedMonth = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Theme
          .of(context)
          .canvasColor,
      height: 250.0,
      child: new Row(
        children: <Widget>[
          new IconButton(
            icon: new Icon(Icons.chevron_left),
            onPressed: () {
              setState(() {
                _displayedMonth = new DateTime(
                  _displayedMonth.year,
                  _displayedMonth.month - 1,
                );
              });
            },
          ),
          new Expanded(
            child: new DayPicker(
              selectedDate: widget.selectedDate,
              currentDate: new DateTime.now(),
              displayedMonth: _displayedMonth,
              firstDate: new DateTime.now().subtract(new Duration(days: 1)),
              lastDate: new DateTime.now().add(new Duration(days: 30)),
              onChanged: widget.onChanged,
            ),
          ),
          new IconButton(
            icon: new Icon(Icons.chevron_right),
            onPressed: () {
              setState(() {
                _displayedMonth = new DateTime(
                  _displayedMonth.year,
                  _displayedMonth.month + 1,
                );
              });
            },
          ),
        ],
      ),
    );
  }
}

class FilterBar extends StatelessWidget {
  FilterBar({ this.isExpanded, this.onExpandedChanged });

  /// Whether this filter bar is showing the day picker or not
  final bool isExpanded;

  /// Called when the user toggles expansion
  final ValueChanged<bool> onExpandedChanged;

  static const Color _kFilterColor = Colors.deepOrangeAccent;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return new Container(
      color: Theme.of(context).canvasColor,
      child: new Row(
        children: <Widget>[
          new FlatButton(
            onPressed: () => onExpandedChanged(!isExpanded),
            textColor: theme.primaryColor,
            child: new Row(
              children: <Widget>[
                new Text('Watch Today'),
                new Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
              ],
            ),
          ),
          new Expanded(
            child: new Container(),
          ),
          new Container(
            decoration: new BoxDecoration(
              color: _kFilterColor,
              borderRadius: new BorderRadius.circular(16.0),
            ),
            padding: const EdgeInsets.all(6.0),
            child: new Text(
              'All Cinemas',
              style: theme.primaryTextTheme.button,
            ),
          ),
          new Container(
            decoration: new BoxDecoration(
              color: _kFilterColor,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(6.0),
            margin: const EdgeInsets.symmetric(
                horizontal: 6.0),
            child: new Text(
              ' + ',
              style: theme.primaryTextTheme.button,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool _isExpanded = false;
  DateTime _selectedDate = new DateTime.now();
  AnimationController _expandAnimationController;
  Animation<Size> _bottomSize;

  @override
  void initState() {
    super.initState();
    _expandAnimationController = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _bottomSize = new SizeTween(
      begin: new Size.fromHeight(kTextTabBarHeight + 40.0),
      end: new Size.fromHeight(kTextTabBarHeight + 280.0),
    ).animate(new CurvedAnimation(
      parent: _expandAnimationController,
      curve: Curves.ease,
    ));
  }

  static const List<Tab> _tabs = const <Tab>[
    const Tab(text: 'NOW SHOWING'),
    const Tab(text: 'COMING SOON'),
  ];

  Widget _buildMovie(BuildContext context, int index) {
    ThemeData theme = Theme.of(context);
    return new Container(
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(
            color: Colors.grey[500],
          ),
        ),
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: new NetworkImage(
            'http://cdn.bloody-disgusting.com/wp-content/uploads/2016/06/hollywood-takes-a-bite-out-of-green-lantern-star-2-new-shark-movies-on-the-horizon-835796.jpg',
          ),
        ),
      ),
      child: new Stack(
        children: <Widget>[
          new Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: new Container(
                  padding: const EdgeInsets.all(20.0),
                  color: Colors.grey[800].withOpacity(0.2),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        '27 Meters Down',
                        style: theme
                            .primaryTextTheme.subhead,
                      ),
                      new Text(
                        'M 1h 29min, Horror',
                        style: theme.primaryTextTheme.
                        caption,
                      ),
                    ],
                  )
              )
          ),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return new PreferredSize(
      child: new SizedBox(
        height: _bottomSize.value.height,
        child: new Column(
          children: <Widget>[
            new TabBar(
              tabs: _tabs,
            ),
            new FilterBar(
              onExpandedChanged: (bool value) async {
                if (value &&
                    _expandAnimationController.isDismissed) {
                  await _expandAnimationController.forward();
                  setState(() {
                    _isExpanded = true;
                  });
                } else if (!value &&
                    _expandAnimationController.isCompleted) {
                  await _expandAnimationController.reverse();
                  setState(() {
                    _isExpanded = false;
                  });
                }
              },
              isExpanded: _isExpanded,
            ),
            new Flexible(
              child: new Stack(
                overflow: Overflow.clip,
                children: <Widget>[
                  new Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: new DayPickerBar(
                      onChanged: (DateTime value) {
                        setState(() {
                          _selectedDate = value;
                        });
                      },
                      selectedDate: _selectedDate,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      preferredSize: _bottomSize.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new Container(),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.filter_list),
        onPressed: () {},
      ),
      body: new DefaultTabController(
        length: _tabs.length,
        child: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              new AnimatedBuilder(
                animation: _bottomSize,
                builder: (BuildContext context, Widget child) {
                  return new SliverAppBar(
                    pinned: true,
                    floating: true,
                    title: const Text('Movies'),
                    actions: <Widget>[
                      new IconButton(
                        icon: new Icon(Icons.search),
                        onPressed: () {},
                      ),
                      new PopupMenuButton(
                        child: new Icon(Icons.more_vert),
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry>[
                            new PopupMenuItem(
                              child: new Text('Not implemented'),
                            )
                          ];
                        },
                      ),
                    ],
                    bottom: _buildBottom(),
                  );
                },
              ),
            ];
          },
          body: new TabBarView(
            children: <Widget>[
              new ListView.builder(
                itemBuilder: _buildMovie,
                itemExtent: 200.0,
              ),
              new Container(
                child: new Center(
                  child: new Text('Coming soon!'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: new HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void main() {
  runApp(new ExampleApp());
}

