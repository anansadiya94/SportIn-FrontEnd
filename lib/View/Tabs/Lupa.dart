import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';

class Lupa extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Lupa"),
        automaticallyImplyLeading: false,
        backgroundColor: color_appbar,
      ),
      backgroundColor: color_background,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[    
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image(
                height: 200.0,
                width: 200.0,
                image: new AssetImage("assets/icono_1.png"),),
              new Text(
                'En construcción', 
                style: new TextStyle(color: color_backgroung_text, fontSize: 40.0),
              ),
            ]
          ),
        ],
      ),
    );
  }
}

