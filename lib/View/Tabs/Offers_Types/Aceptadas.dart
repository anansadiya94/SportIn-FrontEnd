import 'dart:async';
import 'dart:convert';
import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportin/View/Globals.dart' as globals;

class Aceptadas extends StatefulWidget { 
  @override
  AceptadasState createState() => new AceptadasState();
}

class AceptadasState extends State<Aceptadas> {
  var token = globals.tokenPerUser;
  Future<http.Response> _response;
  
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _response = http.get(
        Uri.encodeFull("http://18.218.97.74/sportin-web/symfony/web/app_dev.php/reactedannouncement/$token/2"),
        headers : {
          "Accept": "application/json"
        }
      );
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.refresh),
        onPressed: _refresh,
      ),
      body: new Center(
        child: new FutureBuilder(
          future: _response,
          builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
            if (!response.hasData)
              return new Text('Loading...');
            else if (response.data.statusCode != 200) {
              return new Text('Could not connect to User service.');
            } else {
              List json = jsonCodec.decode((response.data.body));
              return new AceptadasData(json);
            }
          }
        )
      ),
    );
  }
}

class AceptadasData extends StatelessWidget {
  final List data;
  AceptadasData(this.data);
  
  final List<String> _nombre = new List<String>();
  final List<String> _oferta = new List<String>();
  final List<String> _correo = new List<String>();
  final List<String> _foto = new List<String>();
  final List<int> _i = new List<int>();

  @override
  Widget build(BuildContext context){

    Future<String> _popUp(int index) async{
      
      List<String> _a = new List<String>();
      List<String> _b = new List<String>();
      _a.add(data[index]['userName']);
      _b.add(data[index]['email']);

      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
           title: Text('el correo de ${_a[0]}'),
            content: new Text('${_b[0]}'),
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.add),
                color: Colors.blueAccent,
                iconSize: 40.0,
                tooltip: 'Volver atrás',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
      );
    }

    for(int i=0; i<data.length; i++) {
      _nombre.add(data[i]['userName']);
      _oferta.add(data[i]['description']);
      _correo.add(data[i]['email']);
      _foto.add(data[i]['profilePhoto']);
      _i.add(i);
    }
    
    return new Scaffold(
      backgroundColor: color_background,
      body: new ListView.builder(
        itemCount: _nombre.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Container(
              padding: new EdgeInsets.all(15.0),
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    onTap: null,
                    leading: new Hero(
                      tag: index,
                      child: new CircleAvatar(
                        backgroundImage: new MemoryImage(base64Decode(_foto[index])),
                      ),
                    ),
                    title: new Text('${_nombre[index]}', style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                    subtitle: new Text('${_nombre[index]} ha aceptado la oferta -${_oferta[index]}-, clica a Ver correo para poder conectar con ellos.',),
                  ),
                  new Row(
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.only(left: 55.0),
                        child: new FlatButton(
                          onPressed: () {_popUp(_i[index]);},
                          child: new Text('Ver correo',
                            style: new TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 20.0,),
                              )
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

