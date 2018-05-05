import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_list/favorite_widget.dart';
import 'saved_words_list.dart';

Color basicColor = Colors.green;

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter List Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: basicColor,
      ),
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new ListRandomWordsState();
}

class ListRandomWordsState extends State<RandomWords> {
  final _randomWords = <WordPair>[];
  final _savedWords = new Set<WordPair>();
  final _biggerFont = new TextStyle(fontSize: 18.0);

  Widget _buildRow(WordPair pair) {
    return new ListTile(
        title: new Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: new BasicFavoriteButton(
          favorited: _savedWords.contains(pair),
          icon: IconTypes.bookmark,
          color: basicColor,
          onCheck: () {
            _savedWords.add(pair);
          },
          onUncheck: () {
            _savedWords.remove(pair);
          },
        ),
    );
  }

  Widget _buildListView() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        // The itemBuilder callback is called once per random word pairing,
        // and places each word into a ListTile row.
        // For even rows, the function adds a ListTile row for the word pairing.
        // For odd rows, the function adds a Divider widget to visually
        // separate the entries. Note that the divider may be difficult
        // to see on smaller devices.
        itemBuilder: (context, i) {
          // Add a one-pixel-high divider widget before each row in theListView.
          if (i.isOdd) return new Divider();

          // The syntax "i ~/ 2" divides i by 2 and returns an integer result.
          // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
          // This calculates the actual number of word pairings in the ListView,
          // minus the divider widgets.
          final index = i ~/ 2;

          // If you've reached the end of the available word pairings...
          if (index >= _randomWords.length) {
            // ...then generate 10 more and add them to the suggestions list.
            _randomWords.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_randomWords[index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(
        title: new Text('Flutter List View'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.book),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new SavedWordsList(
                            savedWords: _savedWords,
                            basicColor: basicColor,
                        )
                    )
                );
              },
          )
        ],
      ),
      body: _buildListView(),
    );
  }

  void _pushSavedWords() {
    Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (context) {
            final tiles = _savedWords.map(
                  (pair) {
                return new ListTile(
                  title: new Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                );
              },
            );
            final divided = ListTile.divideTiles(
                tiles: tiles,
                context: context
            ).toList();

            return new Scaffold(
              appBar: new AppBar(
                title: new Text('Saved Words'),
              ),
              body: new ListView(children: divided,),
            );
          },
        )
    );
  }
}
