import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

final key = new GlobalKey<_WidgetState>();

class BasicFavoriteButton extends StatefulWidget {

  BasicFavoriteButton({
    Key key,
    this.favorited,
    this.icon,
    this.color,
    this.onCheck,
    this.onUncheck,
  }) : super(key: key);

  final IconTypes icon;
  final Color color;
  final VoidCallback onCheck;
  final VoidCallback onUncheck;
  bool favorited = false;

  @override
  _WidgetState createState() => new _WidgetState();
}

class _WidgetState extends State<BasicFavoriteButton> {

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(0.0),
          child: new IconButton(
              icon: (widget.favorited ?
                      _getCheckedIcon() : _getUncheckedIcon()),
              onPressed: _toggleIcon,
              color: widget.color,
          ),
        ),
      ],
    );
  }

  void _toggleIcon() {
    setState(() {
      if (widget.favorited) {
        widget.onUncheck();
        widget.favorited = false;
      } else {
        widget.onCheck();
        widget.favorited = true;
      }
    });
  }

  Icon _getUncheckedIcon() {
    switch(widget.icon) {
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
    switch(widget.icon) {
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

enum IconTypes {
  star,
  heart,
  bookmark
}