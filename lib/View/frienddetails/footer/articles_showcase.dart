import 'package:flutter/material.dart';
import 'package:sportin/View/friends/friend.dart';

class ArticlesShowcase extends StatelessWidget {
  ArticlesShowcase(this.friend);
  final Friend friend;
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return new Column(
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: new Text(
            friend.historial,
            style: textTheme.body1.copyWith(color: Colors.white70, fontSize: 16.0),
          ),
        ),
      ],
    );
  }
}