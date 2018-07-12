import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sportin/View/friends/friend.dart';

class FriendDetailBody extends StatelessWidget {
  FriendDetailBody(this.friend);

  final Friend friend;

  @override
  Widget build(BuildContext context) {
    Widget nulo = new Text('');
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var locationInfo = new Row(
      children: <Widget>[
        new Container(
          height: 25.0,
          width: 25.0,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/localidad.png'),
            ),
          ),
        ),
        new Text(' '+friend.location, style: textTheme.title.copyWith(color: Colors.white),)
      ],
    );
    var nacionalidadInfo = new Row(
      children: <Widget>[
        new Container(
          height: 25.0,
          width: 25.0,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/nacionalidad.png'),
            ),
          ),
        ),
        new Text(' '+friend.nacionalidad, style: textTheme.title.copyWith(color: Colors.white),)
      ],
    );

    Widget nombreApellido() {
      if(friend.surname!=null) {
        return new Text(
          friend.name+' '+friend.surname,
          style: textTheme.headline.copyWith(color: Colors.white),
        );
      }
      else return new Text(
        friend.name,
        style: textTheme.headline.copyWith(color: Colors.white),
      );
    }
    Widget correo() {
      if(friend.email!=null) {
        return Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Container(
                  height: 25.0,
                  width: 25.0,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage('assets/correo.png'),
                    ),
                  ),
                ),
                new Text(' Correo electrónico : ', style: textTheme.title.copyWith(color: Colors.white),)
              ],
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: new Text(
                friend.email,
                style:
                    textTheme.body1.copyWith(color: Colors.white70, fontSize: 16.0),
              ),
            ),
          ]
        );
      } else return nulo;
    }
    Widget position() {
      if(friend.position!='NULO') {
        return new Row(
          children: [
            new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                  width: 75.0,
                  height: 50.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                      image: new MemoryImage(base64Decode(friend.photoPosition)),
                    ),
                  ),
                )
              ],
            ),
            new Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: new Text(
                friend.position,
                style: textTheme.subhead.copyWith(color: Colors.white),
              ),
            ),
          ],
        );
      } else return nulo;
    }

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        nombreApellido(),
        new Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: locationInfo,
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: nacionalidadInfo
        ),
        new Row(
          children: <Widget>[
            new Container(
              height: 25.0,
              width: 25.0,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('assets/bio.png'),
                ),
              ),
            ),
            new Text(' Biografia : ', style: textTheme.title.copyWith(color: Colors.white),)
          ],
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: new Text(
            friend.bio,
            style:
                textTheme.body1.copyWith(color: Colors.white70, fontSize: 16.0),
          ),
        ),
        position(),
        correo(),
    /*
        new Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: new Row(
            children: [
              _createCircleBadge(Icons.alternate_email, theme.accentColor),
             _createCircleBadge(Icons.train, Colors.white12),
            _createCircleBadge(Icons.shop, Colors.white12),
              
            ],
          ),
        ),
        */
      ],
    );
  }
}
