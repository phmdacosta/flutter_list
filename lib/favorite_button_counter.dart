import 'package:flutter/material.dart';
import 'basic_favorite_button.dart';

class CounterFavoriteButton extends StatefulWidget {
  final IconTypes icon;
  final Color color;

  const CounterFavoriteButton({
    Key key,
    this.icon,
    this.color
  }) : super(key: key);

  @override
  _WidgetState createState() => new _WidgetState(icon, color);
}

class _WidgetState extends State<CounterFavoriteButton> {
  bool _isFavorited = false;
  int _counter = 0;
  IconTypes _icon;
  Color _color;

  _WidgetState(this._icon, this._color);

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(0.0),
          child: new IconButton(
            icon: (_isFavorited ?
            _getCheckedIcon() : _getUncheckedIcon()),
            onPressed: _toggleIcon,
            color: _color,
          ),
        ),
        new SizedBox(
          width: 18.0,
          child: new Container(
            child: new Text('$_counter'),
          ),
        ),
      ],
    );
  }

  void _toggleIcon() {
    setState(() {
      if (_isFavorited) {
        _counter -= 1;
        _isFavorited = false;
      } else {
        _counter += 1;
        _isFavorited = true;
      }
    });
  }

  Icon _getUncheckedIcon() {
    switch(_icon) {
      case IconTypes.star:
        return new Icon(Icons.star_border);
        break;
      case IconTypes.heart:
        return new Icon(Icons.favorite_border);
        break;
      case IconTypes.bookmark:
        return new Icon(Icons.bookmark_border);
        break;
      default:
        return new Icon(Icons.favorite_border);
        break;
    }
  }

  Icon _getCheckedIcon() {
    switch(_icon) {
      case IconTypes.star:
        return new Icon(Icons.star);
        break;
      case IconTypes.heart:
        return new Icon(Icons.favorite);
        break;
      case IconTypes.bookmark:
        return new Icon(Icons.bookmark);
        break;
      default:
        return new Icon(Icons.favorite);
        break;
    }
  }
}