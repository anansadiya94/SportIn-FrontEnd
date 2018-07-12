import 'package:flutter/material.dart';
import 'package:sportin/View/friends/friend.dart';

class SkillsShowcase extends StatelessWidget {
  SkillsShowcase(this.friend);
  final Friend friend;
  @override
  Widget build(BuildContext context) {
    Widget nulo = new Text('');
    var textTheme = Theme.of(context).textTheme;

    Widget fecha() {
      if(friend.edad!=null) {
        return new Row(
          children: <Widget>[
            new Container(
              height: 25.0,
              width: 25.0,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('assets/fecha.png'),
                ),
              ),
            ),
            new Text(' : '+friend.edad, style: textTheme.title.copyWith(color: Colors.white),)
          ],
        );
      } else return nulo;
    }
    
    Widget sexo() {
      if(friend.sexo!=null) {
        if(friend.sexo=='H') {
          return new Row(
            children: <Widget>[
              new Container(
                height: 25.0,
                width: 25.0,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/sexo.png'),
                  ),
                ),
              ),
              new Text(' : Hombre', style: textTheme.title.copyWith(color: Colors.white),)
            ],
          );
        }
        else {
          return new Row(
            children: <Widget>[
              new Container(
                height: 25.0,
                width: 25.0,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/sexo.png'),
                  ),
                ),
              ),
              new Text(' : Mujer', style: textTheme.title.copyWith(color: Colors.white),)
            ],
          );
        }
      } else return nulo;
    } 
    Widget pierna() {
      if(friend.pierna!=null) {
        if(friend.pierna=='D') {
          return new Row(
            children: <Widget>[
              new Container(
                height: 25.0,
                width: 25.0,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/pierna.png'),
                  ),
                ),
              ),
              new Text(' : Diestro', style: textTheme.title.copyWith(color: Colors.white),)
            ],
          );
        }
        else {
          return new Row(
            children: <Widget>[
              new Container(
                height: 25.0,
                width: 25.0,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/pierna.png'),
                  ),
                ),
              ),
              new Text(' : Zurdo', style: textTheme.title.copyWith(color: Colors.white),)
            ],
          );
        }
      } else return nulo;
    } 
    Widget peso() {
      if(friend.peso!=null) {
        return new Row(
          children: <Widget>[
            new Container(
              height: 25.0,
              width: 25.0,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('assets/peso.png'),
                ),
              ),
            ),
            new Text(' : '+friend.peso + ' kg', style: textTheme.title.copyWith(color: Colors.white),)
          ],
        );
      } else return nulo;
    } 
    Widget altura() {
      if(friend.altura!=null) {
        return new Row(
          children: <Widget>[
            new Container(
              height: 25.0,
              width: 25.0,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('assets/altura.png'),
                ),
              ),
            ),
            new Text(' : '+friend.altura + ' cm', style: textTheme.title.copyWith(color: Colors.white),)
          ],
        );
      } else return nulo;
    } 

    return new Column(
      children: <Widget>[
        new Padding(padding: const EdgeInsets.only(top:20.0)),
        fecha(),
        sexo(),
        pierna(),
        altura(),
        peso()
      ],
    );
  }
}