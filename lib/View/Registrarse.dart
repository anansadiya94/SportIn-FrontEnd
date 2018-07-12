import 'dart:convert';
import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportin/View/Globals.dart' as globals;
import 'package:sportin/View/Registrarse/Club/RegistrarseC1.dart';
import 'package:sportin/View/Registrarse/Jugador/RegistrarseJ1.dart';
import 'package:sportin/View/Registrarse/Entrenador_Director/RegistrarseED1.dart';

class Signup extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    const jsonCodec = const JsonCodec();

    void _j() {
      Navigator.push(context,new MaterialPageRoute(builder: (context) => new RegistrarseJ1(1)),);
    }
    void _ed() {
      Navigator.push(context,new MaterialPageRoute(builder: (context) => new RegistrarseED1(1)),);
    }
    void _c() {
      Navigator.push(context,new MaterialPageRoute(builder: (context) => new RegistrarseC1(1)),);
    }

    void _general(int roleId) async {
      //get de populations para la siguiente pestaña.
      var _responseP = await http.get(
        Uri.encodeFull(globals.url+"populations/"),
        headers : {
          "Accept": "application/json"
        }
      );
      globals.populationsG = jsonCodec.decode((_responseP.body));
      for(int i=0; i<globals.populationsG.length; i++) {
        globals.populationsGS.add(globals.populationsG[i]['name']);
        globals.idPopulationsG.add(globals.populationsG[i]['populationid']);
      }
      //get de contries para la siguiente pestaña.
      var _responseC = await http.get(
      Uri.encodeFull(globals.url+"countries/"),
        headers : {
          "Accept": "application/json"
        }
      );
      globals.contries = jsonCodec.decode((_responseC.body));
      for(int i=0; i<globals.contries.length; i++) {
        globals.contriesGS.add(globals.contries[i]['name']);
        globals.idContriesG.add(globals.contries[i]['countryid']);
      }
      //get de roles para la siguiente pestaña.
      var _responseD = await http.get(
      Uri.encodeFull(globals.url+"position"),
        headers : {
          "Accept": "application/json"
        }
      );
      globals.positionsG = jsonCodec.decode((_responseD.body));
      for(int i=0; i<globals.positionsG.length; i++) {
        globals.positionsGS.add(globals.positionsG[i]['name']);
        int positionid = int.parse(globals.positionsG[i]['playerPositionId']);
        assert(positionid is int);
        globals.idPositionsG.add(positionid);
      }
      //get de clubs para la siguiente pestaña.
      var _responseCl = await http.get(
      Uri.encodeFull(globals.url+"clubs"),
        headers : {
          "Accept": "application/json"
        }
      );
      globals.clubsG = jsonCodec.decode((_responseCl.body));
      for(int i=0; i<globals.clubsG.length; i++) {
        globals.clubsGS.add(globals.clubsG[i]['name']);
        int clubid = int.parse(globals.clubsG[i]['clubId']);
        assert(clubid is int);
        globals.idClubsG.add(clubid);
      }
      if(roleId==1) {
        _j();
      } else if(roleId==2) {
        _ed();
      } else {
        _c();
      }
    } 

    Widget padding = new Column(children: <Widget>[new Padding(padding: const EdgeInsets.only(top: 20.0),),],);
    
    Widget jugador = new GestureDetector(
      onTap: (){_general(1);},
      child: new Container(
        height: 100.0,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/prueba_jugador.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    Widget director = new GestureDetector(
      onTap: (){_general(2);},
      child: new Container(
        height: 100.0,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/prueba_director.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    Widget entrenador = new GestureDetector(
      onTap: (){_general(2);},
      child: new Container(
        height: 100.0,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/prueba_entrenador.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    Widget club = new GestureDetector(
      onTap: (){_general(3);},
      child: new Container(
        height: 100.0,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/prueba_club.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    Widget texto = new Text('Elige tu perfil:', style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),);
    
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
              ]
            )
          ]
        )
      )
    );
  }
}
