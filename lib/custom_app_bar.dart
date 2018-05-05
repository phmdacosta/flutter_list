import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget {
  MyAppBar({
    Key key,
    this.title,
    this.body,
  }) : super(key: key);

  final Widget title;
  final Widget body;

  @override
  State<StatefulWidget> createState() => new MyAppBarState();
}

class MyAppBarState extends State<MyAppBar> {

  _Choice _selectedChoice = _choices[0]; // The app's "state".

  void _select(_Choice choice) {
    setState(() { // Causes the app to rebuild with the new _selectedChoice.
      _selectedChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: widget.title,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(_choices[0].icon),
              onPressed: () { _select(_choices[0]); },
          ),
          new PopupMenuButton<_Choice>( // overflow menu
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return _choices.skip(2).map((_Choice choice) {
                return new PopupMenuItem<_Choice>(
                  value: choice,
                  child: new Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: widget.body,
    );
  }
}

class _Choice {
  const _Choice({ this.title, this.icon });
  final String title;
  final IconData icon;
}

const List<_Choice> _choices = const <_Choice>[
  const _Choice(title: 'Favoritos', icon: Icons.book),
  const _Choice(title: 'Bicycle', icon: Icons.directions_bike),
  const _Choice(title: 'Boat', icon: Icons.directions_boat),
  const _Choice(title: 'Bus', icon: Icons.directions_bus),
  const _Choice(title: 'Train', icon: Icons.directions_railway),
  const _Choice(title: 'Walk', icon: Icons.directions_walk),
];