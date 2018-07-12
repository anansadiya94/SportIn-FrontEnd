import 'dart:async';
import 'dart:convert';
import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportin/View/Globals.dart' as globals;

class Rechazadas extends StatefulWidget { 
  @override
  RechazadasState createState() => new RechazadasState();
}

class RechazadasState extends State<Rechazadas> {
  var token = globals.tokenPerUser;
  Future<http.Response> _response;
  
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _response = http.get(
        Uri.encodeFull("http://18.218.97.74/sportin-web/symfony/web/app_dev.php/reactedannouncement/$token/1"),
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
              return new RechazadasData(json);
            }
          }
        )
      ),
    );
  }
}

class RechazadasData extends StatelessWidget {
  final List data;
  RechazadasData(this.data);
  
  final List<String> _nombre = new List<String>();
  final List<String> _oferta = new List<String>();
  final List<String> _foto = new List<String>();

  @override
  Widget build(BuildContext context){
    
    for(int i=0; i<data.length; i++) {
      _nombre.add(data[i]['userName']);
      _oferta.add(data[i]['description']);
      _foto.add(data[i]['profilePhoto']);
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
                    subtitle: new Text('${_nombre[index]} ha rechazdo la oferta -${_oferta[index]}-.',),
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

