import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';


class MyLogo extends StatelessWidget {
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage('assets/LOGO_SPORTIN.jpg');
    var image = new Image(image: assetsImage, width: 300.0, height: 300.0);
    return new Container(child: image);
  }
}

class Portada extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: color_background,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[    
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new MyLogo(),
              new Padding(padding: new EdgeInsets.all(10.0),),
              new Container(
                padding: new EdgeInsets.only(left:50.0,right:50.0),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(40.0),
                  color: color_login_button,
                ),
                child: new Container(
                  child: new FlatButton(
                    onPressed: () {Navigator.of(context).pushNamed("/login");},
                    child: new MaterialButton(
                    textColor: color_icon_text,
                    child: new Text("Iniciar Sesión"),
                      onPressed: () {Navigator.of(context).pushNamed("/login");}
                    ),
                  ),
                ),
              ),
              /*new Padding(padding: new EdgeInsets.all(10.0),),
              new Text(
                'No te has registrado aún? Regístate . . . ', 
                style: new TextStyle(
                  fontSize: 18.0,
                  color: color_backgroung_text
                ),
              ),*/
              new Padding(padding: new EdgeInsets.all(10.0),),
              new Container(
                padding: new EdgeInsets.only(left:50.0,right:50.0),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(40.0),
                  color: color_signup_button,
                ),
                child: new Container(
                  child: new FlatButton(
                    onPressed: () {Navigator.of(context).pushNamed("/signup");},
                    child: new MaterialButton(
                    textColor: color_icon_text,
                    child: new Text("Registrarse"),
                      onPressed: () {Navigator.of(context).pushNamed("/signup");}
                    ),
                  ),
                )
              ),
            ]
          ),
        ]
      )
    );
  }
}