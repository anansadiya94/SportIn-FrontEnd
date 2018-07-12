import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';
import 'package:sportin/View/Crear_Oferta/CrearOfertaJ.dart';
import 'package:sportin/View/Crear_Oferta/CrearOfertaE.dart';
import 'package:sportin/View/Crear_Oferta/CrearOfertaD.dart';
import 'package:sportin/View/Crear_Oferta/CrearOfertaC.dart';


class CrearOferta extends StatefulWidget { 
  @override
  CrearOfertaState createState() => new CrearOfertaState();
}

class CrearOfertaState extends State<CrearOferta> {

  @override
  Widget build(BuildContext context) {
    Widget padding = new Column(children: <Widget>[new Padding(padding: const EdgeInsets.only(top: 20.0),),],);
    
    Widget jugador = new GestureDetector(
      onTap: () { Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new CrearOfertaJ(1)),);},
      child: new Container(
        height: 100.0,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/prueba_jugador_2.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    Widget entrenador = new GestureDetector(
      onTap: () {Navigator.push(context,new MaterialPageRoute(builder: (context) => new CrearOfertaE(2)),);},
      child: new Container(
        height: 100.0,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/prueba_entrenador_2.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    Widget director = new GestureDetector(
      onTap: () {Navigator.push(context,new MaterialPageRoute(builder: (context) => new CrearOfertaD(3)),);},
      child: new Container(
        height: 100.0,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/prueba_director_2.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    Widget club = new GestureDetector(
      onTap: () {Navigator.push(context,new MaterialPageRoute(builder: (context) => new CrearOfertaC(4)),);},
      child: new Container(
        height: 100.0,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/prueba_club_2.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    Widget cancel = new MaterialButton(
      color: Colors.blueGrey,
      textColor: color_icon_text,
      child: new Text("Cancelar"),
      onPressed: () {Navigator.pop(context);},
    );

    Widget texto = new Text('A quién estás buscando?', style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),);
    
    return new Scaffold(
      backgroundColor: color_background,
      body: new Container(
        alignment: new FractionalOffset(0.0, 0.5),
        margin: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: new ListView(
          children: [
            new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                texto,
                padding,
                jugador,
                padding,
                entrenador,
                padding,
                director,
                padding,
                club,
                padding,
                cancel,
              ]
            )
          ]
        )
      )
    );
  }
}
