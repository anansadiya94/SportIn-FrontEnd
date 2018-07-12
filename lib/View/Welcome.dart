import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';


class Welcome extends StatefulWidget {
  final String name;
  Welcome(this.name);
  @override
  _WelcomeState createState() => new _WelcomeState(name);
}

class _WelcomeState extends State<Welcome> {
  String name;
  _WelcomeState(this.name);
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/Welcome_photo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[    
            new Column(
              children: <Widget>[
                new Padding(padding: const EdgeInsets.only(top: 250.0),),
                new Text(
                  'Bienvenido $name',
                  style: new TextStyle(color: Colors.white, fontSize: 40.0),
                ),
                new Padding(padding: const EdgeInsets.only(top: 20.0),),
                new MaterialButton(
                  color: color_signup_button,
                  textColor: color_icon_text,
                  child: new Text("Entrar"),
                  onPressed: () {Navigator.of(context).pushNamed("/tabs");},
                ),
              ]
            ),
          ],
        ),
      )
    );
  }
}

