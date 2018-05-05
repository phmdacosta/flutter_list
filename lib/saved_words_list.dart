import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class SavedWordsList extends StatelessWidget {

  SavedWordsList({
    Key key,
    this.savedWords,
    this.basicColor,
  }) : super(key: key);

  final Set<WordPair> savedWords;
  final Color basicColor;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter List Demo',
      theme: new ThemeData(
        primarySwatch: basicColor,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Saved Words'),
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: null
          ),
        ),
        body: new _WordsList(savedWords: savedWords),
      ),
    );
  }
}

class _WordsList extends StatefulWidget {
  const _WordsList({
    Key key,
    this.savedWords,
  }) : super(key: key);

  final Set<WordPair> savedWords;

  @override
  _ListRandomWordsState createState() => new _ListRandomWordsState();
}

class _ListRandomWordsState extends State<_WordsList> {
  final _biggerFont = new TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return _buildListView(widget.savedWords);
  }

  Widget _buildListView(Set<WordPair> list) {
    final iterable = list.map(
        (pair) {
          return new ListTile(
              title: new Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
          );
        },
    );

    final dividedList = ListTile.divideTiles(
        tiles: iterable,
        context: context
    ).toList();

    return new ListView(children: dividedList);
  }
}